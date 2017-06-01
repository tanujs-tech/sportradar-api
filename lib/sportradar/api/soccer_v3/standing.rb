module Sportradar
  module Api
    class SoccerV3::Standing < Data
      attr_accessor :response, :categories

      def initialize(data)
        @response = data
        @categories = parse_into_array(selector: response["categories"]["category"], klass: Sportradar::Api::SoccerV3::Category)  if response["categories"] && response["categories"]["category"]
      end

    end
  end
end
