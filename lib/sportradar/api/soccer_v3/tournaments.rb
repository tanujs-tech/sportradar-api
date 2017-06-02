# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Tournaments < Data
      attr_accessor :response, :tournaments

      def initialize(data)
        @response = data
        tournaments_details = response.fetch('tournaments')&.fetch('tournament')
        @tournaments = parse_into_array(selector: tournaments_details, klass: Sportradar::Api::SoccerV3::Tournament) if tournaments_details
      end
    end
  end
end
