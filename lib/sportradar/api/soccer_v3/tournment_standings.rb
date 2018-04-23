# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::TournamentStandings < Data
      attr_accessor :response,
                    :tournament,
                    :season,
                    :standings

      def initialize(data)
        @response = data
        @total = @response.detect { |a| a[:type] == 'total' }
        @home = @response.detect { |a| a[:type] == 'home' }
        @away = @response.detect { |a| a[:type] == 'away' }
        @sport_events = parse_into_array(selector: standings, klass: Sportradar::Api::SoccerV3::SportEvent)
      end
    end
  end
end
