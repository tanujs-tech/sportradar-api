# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Schedule < Data
      attr_accessor :response, :matches

      def initialize(data)
        @response = data
        @matches = parse_into_array(selector: response['schedule']['matches']['match'], klass: Sportradar::Api::SoccerV3::Match) if response['schedule'] && response['schedule']['matches'] && response['schedule']['matches']['match']
      end

      def league(league_name)
        matches.select { |match| match.tournament_group.name.parameterize == league_name.parameterize }
      end

      def available_leagues
        matches.map { |match| match.tournament_group.name }.uniq
      end
    end
  end
end
