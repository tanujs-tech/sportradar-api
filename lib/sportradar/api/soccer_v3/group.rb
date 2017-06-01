# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Group < Data
      attr_accessor :response,
                    :name,
                    :team

      def initialize(data)
        @response = data
        @name = data['name']
        @team = parse_into_array(selector: data['team'], klass: Sportradar::Api::SoccerV3::Team)
      end
    end
  end
end
