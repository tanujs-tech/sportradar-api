# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Season < Data
      attr_accessor :response,
                    :name,
                    :start_date,
                    :end_date,
                    :year,
                    :tournament_id

      def initialize(data)
        @response = data
        @id = data['id']
        @name = data['name']
        @start_date = data['start_date']
        @end_date = data['end_date']
        @year = data['year']
        @tournament_id = data['tournament_id']
        # @statistics = parse_into_array(selector: response['statistic'], klass: Sportradar::Api::SoccerV3::Statistic) if response['statistic']
      end
    end
  end
end
