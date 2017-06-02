# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Role < Data
      attr_accessor :response,
                    :type,
                    :active,
                    :start_date,
                    :jersey_number,
                    :team

      def initialize(data)
        @response = data
        @type = data[:type]
        @active = data[:active]
        @start_date = data[:start_date]
        @jersey_number = data[:jersey_number]
        @team = Sportradar::Api::SoccerV3::Team.new(data[:team])
      end
    end
  end
end
