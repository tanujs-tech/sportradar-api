# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Tournament < Data
      attr_accessor :response,
                    :id,
                    :name,
                    :sport,
                    :current_season,
                    :season_start,
                    :season_end,
                    :year,
                    :type,
                    :season_coverage_info,
                    :teams,
                    :category

      def initialize(data)
        @response = data
        @id = data['id']
        @name = data['name']
        @sport = OpenStruct.new data['sport']

        @current_season = Sportradar::Api::SoccerV3::Season.new data[:current_season] if data[:current_season]

        @season_start = current_season&.start_date
        @season_end = current_season&.end_date

        @year = current_season&.year

        @season_coverage_info = OpenStruct.new data['season_coverage_info'] if data['season_coverage_info']

        @category = Sportradar::Api::SoccerV3::Category.new(data[:category]) if data[:category]
      end
    end
  end
end
