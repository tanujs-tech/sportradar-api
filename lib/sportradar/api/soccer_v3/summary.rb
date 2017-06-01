module Sportradar
  module Api
    class SoccerV3::Summary < Data
      attr_accessor :response, :matches

      def initialize(data)
        @response = data
        @matches = parse_into_array(selector: response["summary"]["matches"]["match"], klass: Sportradar::Api::SoccerV3::Match)  if response['summary'] && response['summary']['matches'] && response["summary"]["matches"]["match"]
      end

    end
  end
end
