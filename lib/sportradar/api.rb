# frozen_string_literal: true

require 'rubygems'
require 'active_support/all'
require 'httparty'

require 'sportradar/api/version'

require 'sportradar/api/config'
require 'sportradar/api/data'
require 'sportradar/api/error'
require 'sportradar/api/request'
require 'sportradar/api/poll'

require 'sportradar/api/broadcast'

require 'sportradar/api/soccer'
require 'sportradar/api/soccer/boxscore'
require 'sportradar/api/soccer/category'
require 'sportradar/api/soccer/fact'
require 'sportradar/api/soccer/hierarchy'
require 'sportradar/api/soccer/match'
require 'sportradar/api/soccer/player'
require 'sportradar/api/soccer/ranking'
require 'sportradar/api/soccer/schedule'
require 'sportradar/api/soccer/season'
require 'sportradar/api/soccer/standing'
require 'sportradar/api/soccer/statistic'
require 'sportradar/api/soccer/summary'
require 'sportradar/api/soccer/team'
require 'sportradar/api/soccer/tournament'
require 'sportradar/api/soccer/tournament_group'
require 'sportradar/api/soccer/venue'

require 'sportradar/api/soccer_v3'
require 'sportradar/api/soccer_v3/boxscore'
require 'sportradar/api/soccer_v3/category'
require 'sportradar/api/soccer_v3/fact'
require 'sportradar/api/soccer_v3/hierarchy'
require 'sportradar/api/soccer_v3/match'
require 'sportradar/api/soccer_v3/player'
require 'sportradar/api/soccer_v3/player_role'
require 'sportradar/api/soccer_v3/ranking'
require 'sportradar/api/soccer_v3/schedule'
require 'sportradar/api/soccer_v3/season'
require 'sportradar/api/soccer_v3/standing'
require 'sportradar/api/soccer_v3/statistic'
require 'sportradar/api/soccer_v3/summary'
require 'sportradar/api/soccer_v3/team'
require 'sportradar/api/soccer_v3/sport_event'
require 'sportradar/api/soccer_v3/tournament'
require 'sportradar/api/soccer_v3/tournament_info'
require 'sportradar/api/soccer_v3/tournament_schedule'
require 'sportradar/api/soccer_v3/tournaments'
require 'sportradar/api/soccer_v3/group'
require 'sportradar/api/soccer_v3/tournament_group'
require 'sportradar/api/soccer_v3/venue'

require 'sportradar/api/football'
require 'sportradar/api/ncaafb'
require 'sportradar/api/ncaafb/season'
require 'sportradar/api/ncaafb/week'
require 'sportradar/api/ncaafb/game'
require 'sportradar/api/ncaafb/team'
require 'sportradar/api/ncaafb/player'
require 'sportradar/api/ncaafb/quarter'
require 'sportradar/api/ncaafb/drive'
require 'sportradar/api/ncaafb/play'

require 'sportradar/api/nfl'
require 'sportradar/api/nfl/broadcast'
require 'sportradar/api/nfl/changelog'
require 'sportradar/api/nfl/coach'
require 'sportradar/api/nfl/conference'
require 'sportradar/api/nfl/depth_chart'
require 'sportradar/api/nfl/division'
require 'sportradar/api/nfl/draft'
require 'sportradar/api/nfl/drive'
require 'sportradar/api/nfl/event'
require 'sportradar/api/nfl/franchise'
require 'sportradar/api/nfl/game'
require 'sportradar/api/nfl/game_statistic'
require 'sportradar/api/nfl/hierarchy'
require 'sportradar/api/nfl/injury'
require 'sportradar/api/nfl/league_depth_chart'
require 'sportradar/api/nfl/play'
require 'sportradar/api/nfl/play_statistics'
require 'sportradar/api/nfl/player'
require 'sportradar/api/nfl/position'
require 'sportradar/api/nfl/quarter'
require 'sportradar/api/nfl/scoring'
require 'sportradar/api/nfl/season'
require 'sportradar/api/nfl/situation'
require 'sportradar/api/nfl/statistic'
require 'sportradar/api/nfl/summary'
require 'sportradar/api/nfl/team'
require 'sportradar/api/nfl/team_depth_chart'
require 'sportradar/api/nfl/venue'
require 'sportradar/api/nfl/week'

require 'sportradar/api/basketball'
require 'sportradar/api/baseball'

require 'sportradar/api/live_images'
require 'sportradar/api/images'
require 'sportradar/api/images/asset_list'
require 'sportradar/api/images/asset'
require 'sportradar/api/images/link'
require 'sportradar/api/images/ref'
require 'sportradar/api/images/tag'

require 'sportradar/api/mma'
require 'sportradar/api/mma/schedule'
require 'sportradar/api/mma/roster'
require 'sportradar/api/mma/fighter'
require 'sportradar/api/mma/event'
require 'sportradar/api/mma/fight'
require 'sportradar/api/mma/judge'
require 'sportradar/api/mma/referee'
require 'sportradar/api/mma/result'
require 'sportradar/api/mma/score'
require 'sportradar/api/mma/venue'
require 'sportradar/api/mma/league'

require 'sportradar/api/content'
require 'sportradar/api/content/article_list'
require 'sportradar/api/content/article'
require 'sportradar/api/content/reference'
require 'sportradar/api/odds'

require 'sportradar/api/rugby'

module Sportradar
  module Api
    API_GALLERY = [
      { api: :nfl, version: 1 },
      { api: :mlb, version:  6 },
      { api: :nhl, version:  3 },
      { api: :nba, version:  3 },
      { api: :ncaamb, version:   3 },
      { api: :ncaafb, version:   1 },
      { api: :golf, version: 2 },
      { api: :nascar, version: 3 },
      { api: :odds, version: 1 },
      { api: :content, version:  3 },
      { api: :images, version:   2 },
      { api: :live_images, version: 1 },
      { api: :olympics, version: 2 },
      { api: :soccer, version: 2 },
      { api: :soccerv3, version: 3 },
      { api: :ncaawb, version: 3 },
      { api: :mma, version: 1 },
      { api: :cricket, version: 1 },
      { api: :wnba, version: 3 },
      { api: :ncaamh, version: 3 },
      { api: :npb, version: 1 },
      { api: :rugby, version: 1 },
      { api: :tennis, version:   1 },
      { api: :esports, version:  1 }
    ].freeze

    private

    def self.api_key_params(api, access_level = 'trial')
      { api_key: api_key(api, access_level) }
    end

    def self.api_key(api, access_level = 'trial')
      Figaro.env.send("SPORTRADAR_#{api.to_s.upcase.tr('-', '_')}#{'_PRODUCTION' if access_level == 'production'}", "api_key missing for #{api}")
    end

    def self.version(api)
      find_api = API_GALLERY.find { |x| x[:api] == api.downcase.to_sym }
      !find_api.nil? ? find_api[:version] : "version missing for #{api}"
    end
  end
end
