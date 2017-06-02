# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Statistic < Data
      attr_accessor :response,
                    :matches_played,
                    :substituted_in,
                    :substituted_out,
                    :goals_scored,
                    :assists,
                    :own_goals,
                    :yellow_cards,
                    :yellow_red_cards,
                    :red_cards,
                    :last_event_time

      def initialize(data)
        @response = data
        @matches_played = data[:matches_played]
        @substituted_in = data[:substituted_in]
        @substituted_out = data[:substituted_out]
        @goals_scored = data[:goals_scored]
        @assists = data[:assists]
        @own_goals = data[:own_goals]
        @yellow_cards = data[:yellow_cards]
        @yellow_red_cards = data[:yellow_red_cards]
        @red_cards = data[:red_cards]
        @last_event_time = data[:last_event_time]
      end
    end
  end
end
