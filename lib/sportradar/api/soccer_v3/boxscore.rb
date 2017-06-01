module Sportradar
  module Api
    class SoccerV3::Boxscore < Data
      attr_accessor :response, :matches

      def initialize(data)
        @response = data
        @matches = parse_into_array(selector: response["boxscore"]["matches"]["match"], klass: Sportradar::Api::SoccerV3::Match)  if response['boxscore'] && response['boxscore']['matches'] && response["boxscore"]["matches"]["match"]
      end

    end
  end
end
