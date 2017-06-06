# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::TournamentInfo < Data
      attr_accessor :response,
                    :tournament,
                    :season,
                    :round,
                    :season_coverage_info,
                    :coverage_info,
                    :groups

      def initialize(data)
        @response = data
        @tournament = Sportradar::Api::SoccerV3::Tournament.new data[:tournament]
        @season = Sportradar::Api::SoccerV3::Season.new data[:season]
        @round = OpenStruct.new data['round']
        @season_coverage_info = OpenStruct.new data['season_coverage_info'] if data['season_coverage_info']
        @coverage_info = OpenStruct.new data['coverage_info']

        groups_details = data.fetch('groups')&.fetch('group')&.send :[], 0...-1

        teams = data.fetch('groups')&.fetch('group')&.last&.fetch('team')

        @groups = OpenStruct.new('groups': parse_into_array(selector: groups_details, klass: Sportradar::Api::SoccerV3::Group),
                                 'teams': parse_into_array(selector: teams, klass: Sportradar::Api::SoccerV3::Team))
      end
    end
  end
end
