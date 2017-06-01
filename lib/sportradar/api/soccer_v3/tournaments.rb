# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Tournaments < Data
      attr_accessor :response, :tournaments

      def initialize(data)
        @response = data
        tournaments = response.fetch('tournaments')&.fetch('tournament')
        @tournaments = parse_into_array(selector: tournaments, klass: Sportradar::Api::SoccerV3::Tournament) if tournaments
      end
    end
  end
end
