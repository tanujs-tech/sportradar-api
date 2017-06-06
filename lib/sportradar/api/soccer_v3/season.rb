# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Season < Data
      attr_accessor :response,
                    :id,
                    :name,
                    :start_date,
                    :end_date,
                    :year,
                    :tournament_id,
                    :tournament,
                    :season_coverage_info

      def initialize(data)
        @response = data
        @id = data['id']
        @name = data['name']
        @start_date = data['start_date']&.to_date
        @end_date = data['end_date']&.to_date
        @year = data['year']
        @tournament_id = data['tournament_id']
        @tournament = Sportradar::Api::SoccerV3::Tournament.new(data[:tournament]) if data[:tournament]
        @season_coverage_info = OpenStruct.new(data[:season_coverage_info]) if data[:season_coverage_info]
        @statistics = parse_into_array(selector: response['statistic'], klass: Sportradar::Api::SoccerV3::Statistic) if response['statistic']
      end
    end
  end
end
