# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::TournamentSchedule < Data
      attr_accessor :response,
                    :tournament,
                    :sport_events

      def initialize(data)
        @response = data
        @tournament = Sportradar::Api::SoccerV3::Tournament.new data[:tournament]
        events = data[:sport_events][:sport_event]
        @sport_events = parse_into_array(selector: events, klass: Sportradar::Api::SoccerV3::SportEvent)
      end
    end
  end
end
