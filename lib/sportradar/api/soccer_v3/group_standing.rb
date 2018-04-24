# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::GroupStanding < Data
      attr_accessor :response,
                    :name,
                    :team_standing

      def initialize(data)
        @response = data
        @name = data[:name]
        @team_standing = parse_data(data[:team_standing])
      end

      private

      def parse_data(team_standings)
        team_standings.collect do |team_standing|
          parse_into_array(selector: team_standing, klass: Sportradar::Api::SoccerV3::TeamStanding)
        end
      end
    end
  end
end
