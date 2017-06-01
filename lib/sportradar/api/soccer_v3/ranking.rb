module Sportradar
  module Api
    class SoccerV3::Ranking < Data
      attr_accessor :response, :categories

      def initialize(data)
        @response = data
        @categories = parse_into_array(selector: response["category"], klass: Sportradar::Api::SoccerV3::Category)  if response["category"]
      end

    end
  end
end
