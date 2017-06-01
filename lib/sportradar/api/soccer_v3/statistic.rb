# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Statistic < Data
      attr_accessor :response, :year, :statistics

      def initialize(data)
        @response = data
        @year = data['year']
      end
    end
  end
end
