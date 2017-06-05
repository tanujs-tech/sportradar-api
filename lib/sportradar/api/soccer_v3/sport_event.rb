# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::SportEvant < Data
      attr_accessor :response,
                    :id,
                    :scheduled,
                    :start_time_tbd,
                    :status,
                    :tournament_round,
                    :season,
                    :tournament,
                    :competitors

      def initialize(data)
        @response = data
        @id = data[:id]
        @scheduled = data[:scheduled]
        @start_time_tbd = data[:start_time_tbd]
        @status = data[:status]

        @tournament_round = OpenStruct.new data[:tournament_round]
        @season = Sportradar::Api::SoccerV3::Season.new data[:season]

        @tournament = Sportradar::Api::SoccerV3::Tournament.new data[:tournament]

        @competitors = OpenStruct.new(
          teams: parse_into_array(selector: data[:competitors][:team], klass: Sportradar::Api::SoccerV3::Team)
        )
      end
    end
  end
end
