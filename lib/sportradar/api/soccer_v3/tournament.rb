# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3::Tournament < Data
      attr_accessor :response,
                    :id,
                    :name,
                    :sport,
                    :current_season,
                    :season_start,
                    :season_end,
                    :type,
                    :reference_id,
                    :season_coverage_info,
                    :teams,

                    def initialize(data)
                      @response = data
                      @id = data['id']
                      @name = data['name']
                      @sport = OpenStruct.new data['sport']
                      @current_season = data['current_season']

                      @season_start = data['season_start']
                      @season_end = data['season_end']
                      @reference_id = data['reference_id']
                      @season_coverage_info = OpenStruct.new data['season_coverage_info'] if data['season_coverage_info']
                      @teams = parse_into_array(selector: response['team'], klass: Sportradar::Api::SoccerV3::Team) if response['team']
                    end
    end
  end
end

# {"id"=>"sr:tournament:7",
#   "name"=>"UEFA Champions League",

#   "sport"=>{"id"=>"sr:sport:1", "name"=>"Soccer"},
#   "category"=>{"id"=>"sr:category:393", "name"=>"International Clubs"},
#   "current_season"=>
#    {"id"=>"sr:season:33051", "name"=>"UEFA Champions League 16/17", "start_date"=>"2016-06-26", "end_date"=>"2017-06-05", "year"=>"16/17"},

#   "season_coverage_info"=>
#    {"season_id"=>"sr:season:33051",
#     "scheduled"=>"30",
#     "played"=>"223",
#     "max_coverage_level"=>"platinum",
#     "max_covered"=>"144",
#     "min_coverage_level"=>"bronze"}
# }
