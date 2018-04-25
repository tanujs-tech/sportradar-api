# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::TournamentStandings < Data
      attr_accessor :response,
                    :tournament,
                    :season,
                    :standings

      def initialize(data)
        @tournament = parse_into_array(selector: data[:tournament], klass: Sportradar::Api::SoccerV3::Tournament)
        @season = parse_into_array(selector: data[:season], klass: Sportradar::Api::SoccerV3::Season)
        @response = data[:standings]
        total_teams = @response.detect { |a| a[:type] == 'total' } || {}

        # TODO: when needed
        # home = @response.detect { |a| a[:type] == 'home' }
        # away = @response.detect { |a| a[:type] == 'away' }

        @standings = parse_data(total_teams[:group])
      end

      private

      def parse_data(total_teams)
        total_teams.collect do |total_team|
          parse_into_array(selector: total_team, klass: Sportradar::Api::SoccerV3::GroupStanding)
        end
      end
    end
  end
end
