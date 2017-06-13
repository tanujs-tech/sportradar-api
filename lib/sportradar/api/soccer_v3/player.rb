# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Player < Data
      attr_accessor :response,
                    :id,
                    :first_name,
                    :last_name,
                    :full_name,
                    :type,
                    :date_of_birth,
                    :nationality,
                    :country_code,
                    :height,
                    :weight,
                    :preferred_foot,
                    :team,
                    :roles,
                    :jersey_number,
                    :statistics
      # :reference_id,
      # :full_first_name,
      # :full_last_name,
      # :position,
      # :started,
      # :tactical_position,
      # :tactical_order,
      # :statistics,
      # :preferred_foot,
      # :birthdate,
      # :height_in,
      # :weight_lb,
      # :height_cm,
      # :weight_kg,
      # :teams,
      # :response,
      # :rank,
      # :total,
      # :statistics,
      # :last_modified

      def initialize(data)
        @response = data
        player_data = data[:player] || data

        @id = player_data['id']
        @full_name = player_data[:name]
        @first_name = first_name
        @last_name = last_name
        @type = player_data[:type]
        @date_of_birth = player_data[:date_of_birth]
        @nationality = player_data[:nationality]
        @country_code = player_data[:country_code]
        @height = player_data[:height]
        @weight = player_data[:weight]
        @preferred_foot = player_data[:preferred_foot]

        # @teams = parse_into_array(selector: response['team'], klass: Sportradar::Api::SoccerV3::Team) if response['team']
        @team = Sportradar::Api::SoccerV3::Team.new(data[:teams][:team]) if response[:team]

        player_roles = data[:roles][:role] if response[:roles]
        @roles = parse_into_array(selector: player_roles, klass: Sportradar::Api::SoccerV3::Role) if player_roles

        # @reference_id = data['reference_id']
        # @full_first_name = data['full_first_name']
        # @full_last_name = data['full_last_name']
        # @position = data['position'] || primary_team.try(:position)
        # @started = data['started']
        @jersey_number = player_data[:jersey_number] # || primary_team.try(:jersey_number)
        # @tactical_position = data['tactical_position']
        # @tactical_order = data['tactical_order']
        # @last_modified = data['last_modified']

        # profile
        # @preferred_foot = data['preferred_foot']
        # @birthdate = data['birthdate']q
        # @height_in = data['height_in']
        # @weight_lb = data['weight_lb']
        # @height_cm = data['height_cm']
        # @weight_kg = data['weight_kg']
        # @rank = data['rank']
        # @total = OpenStruct.new data['total'] if data['total']
        @statistics = OpenStruct.new(
          seasons: parse_into_array(selector: response[:statistics][:seasons][:season], klass: Sportradar::Api::SoccerV3::Season),
          totals: Sportradar::Api::SoccerV3::Statistic.new(response[:statistics][:totals][:statistics])
        ) if response[:statistics]
      end

      # def name
      #   [first_name, last_name].join(' ')
      # end

      # def full_name
      #   full = [full_first_name, full_last_name].join(' ')
      #   full == ' ' ? name : full
      # end

      def first_name
        full_name.split(', ')[1]
      end

      def last_name
        full_name.split(', ')[0]
      end

      def position_name
        positions = { 'G' => 'Goalie', 'D' => 'Defender', 'M' => 'Midfielder', 'F' => 'Forward', '' => 'N/A' }
        if position
          positions[position]
        elsif primary_team.present?
          positions[primary_team.position]
        end
      end

      def primary_team
        if teams
          if teams.count == 1
            teams.first
          else
            teams.find { |team| team.name != team.country_code }
          end
        end
      end

      def tactical_position_name
        tactical_positions = { '0' => 'Unknown', '1' => 'Goalkeeper', '2' => 'Right Back', '3' => 'Central Defender', '4' => 'Left Back', '5' => 'Right winger', '6' => 'Central Midfielder', '7' => 'Left Winger', '8' => 'Forward' }
        tactical_positions[tactical_position] if tactical_position
      end

      def age
        if date_of_birth.present?
          now = Time.now.utc.to_date
          dob = date_of_birth.to_date
          now.year - dob.year - (now.month > dob.month || (now.month == dob.month && now.day >= dob.day) ? 0 : 1)
        end
      end

      # def height_ft
      #   if height_in.present?
      #     feet, inches = height_in.to_i.divmod(12)
      #     "#{feet}' #{inches}\""
      #   end
      # end
    end
  end
end
