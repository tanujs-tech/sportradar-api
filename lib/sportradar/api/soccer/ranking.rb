# frozen_string_literal: true

module Sportradar
  module Api
    class Soccer::Ranking < Data
      attr_accessor :response, :categories

      def initialize(data)
        @response = data
        @categories = parse_into_array(selector: response['category'], klass: Sportradar::Api::Soccer::Category) if response['category']
      end
    end
  end
end
