# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Team < Data
      attr_accessor :response,
                    :id,
                    :name,
                    :full_name,
                    :alias,
                    :country_code,
                    :country,
                    :type,
                    :reference_id,
                    :formation,
                    :score,
                    :regular_score,
                    :penalty_score,
                    :winner,
                    :scoring,
                    :statistics,
                    :first_half_score,
                    :second_half_score,
                    :players,
                    :manager,
                    :roster,
                    :rank,
                    :win,
                    :draw,
                    :loss,
                    :goals_for,
                    :goals_against,
                    :points,
                    :change,
                    :goals_diff,
                    :jersey_number,
                    :position,
                    :is_player,
                    :is_manager,
                    :home,
                    :away,
                    :abbreviation,
                    :qualifier

      def initialize(data)
        @response = data
        team_data = data['team'] || data
        @id = team_data['id']
        @reference_id = team_data['reference_id']
        @name = team_data['name']
        @full_name = team_data['full_name'] || team_data['name']
        @alias = team_data['alias']
        @country_code = team_data['country_code']
        @country = team_data['country']
        @type = team_data['type']
        @formation = team_data['formation']
        @score = team_data['score']
        @regular_score =  team_data['regular_score']
        @penalty_score =  team_data['penalty_score']
        @winner = team_data['winner']
        @rank = team_data['rank']
        @win = team_data['win']
        @draw = team_data['draw']
        @loss = team_data['loss']
        @goals_for = team_data['goals_for']
        @goals_against = team_data['goals_against']
        @points = team_data['points']
        @change = team_data['change']
        @goals_diff = team_data['goals_diff']
        @jersey_number = team_data['jersey_number']
        @position = team_data['position']
        @is_player = team_data['is_player']
        @is_manager = team_data['is_manager']

        # Standings generate these
        @home = OpenStruct.new team_data['home'] if team_data['home']
        @away = OpenStruct.new team_data['away'] if team_data['away']

        @scoring = OpenStruct.new team_data['scoring'] if team_data['scoring']
        parse_scoring if scoring

        @statistics = OpenStruct.new data['statistics'] if data['statistics']
        @players = parse_into_array(selector: data[:players][:player], klass: Sportradar::Api::SoccerV3::Player) if response['players'] && response['players']['player']
        # @players = parse_into_array(selector: data['roster']['player'], klass: Sportradar::Api::SoccerV3::Player) if response['roster'] && response['roster']['player']
        @manager = Sportradar::Api::SoccerV3::Player.new data['manager'] if data['manager']
        @abbreviation = team_data['abbreviation']
        @qualifier = team_data['qualifier']
      end

      alias roster players

      private

      def parse_scoring
        if scoring.half.is_a?(Array)
          @first_half_score = scoring.half.find { |x| x['number'] == '1' }['points']
          @second_half_score = scoring.half.find { |x| x['number'] == '2' }['points']
        elsif scoring.half.is_a?(Hash)
          @first_half_score = scoring.half['points']
        end
      end
    end
  end
end
