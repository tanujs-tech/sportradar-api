# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::TournamentSchedule < Data
      attr_accessor :response,
                    :tournament,
                    :sport_events

      def initialize(data)
        @response = data
        tournament_schedule = data[:tournament_schedule]
        @tournament = Sportradar::Api::SoccerV3::Tournament.new tournament_schedule[:tournament]
        events = tournament_schedule[:sport_events][:sport_event]
        @sport_events = parse_into_array(selector: events, klass: Sportradar::Api::SoccerV3::SportEvant)
      end
    end
  end
end
