module Sportradar
  module Api
    class SoccerV3::Season < Data
      attr_accessor :response, :year, :statistics

      def initialize(data)
        @response = data
        @year = data["year"]
        @statistics = parse_into_array(selector: response["statistic"], klass: Sportradar::Api::SoccerV3::Statistic)  if response["statistic"]
      end

    end
  end
end
