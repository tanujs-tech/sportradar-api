# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::TeamBasic < Data
      attr_accessor :response,
                    :id,
                    :name,
                    :full_name

      def initialize(data)
        @response = data
        team_data = data['team'] || data
        @id = team_data['id']
        @name = team_data['name']
        @full_name = team_data['full_name'] || team_data['name']
      end
    end
  end
end
