# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::TeamStanding < Data
      attr_accessor :response,
                    :team,
                    :rank,
                    :current_outcome,
                    :played,
                    :win,
                    :draw,
                    :loss,
                    :goals_for,
                    :goals_against,
                    :goal_diff,
                    :points

      def initialize(data)
        @response = data
        @team = parse_into_array(selector: data['team'], klass: Sportradar::Api::SoccerV3::TeamBasic)
        @rank = data['rank']
        @current_outcome = data['current_outcome']
        @played = data['played']
        @win = data['win']
        @draw = data['draw']
        @loss = data['loss']
        @goals_for = data['goals_for']
        @goals_against = data['goals_against']
        @goal_diff = data['goal_diff']
        @points = data['points']
      end
    end
  end
end