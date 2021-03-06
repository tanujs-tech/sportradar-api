# frozen_string_literal: true

module Sportradar
  module Api
    module Basketball
      class Nba
        class Schedule < Data
          attr_accessor :response, :id, :name, :alias, :date

          def initialize(data, **opts)
            @response = data
            @api      = opts[:api]

            # binding.pry
            # ['league']
            @id       = data.dig('league', 'id')
            @name     = data.dig('league', 'name')
            @alias    = data.dig('league', 'alias')
            @date     = data.dig('date')

            @games_hash = {}
            update_games(data.dig('games'))
          end

          def games
            @games_hash.values
          end

          def update_games(data)
            create_data(@games_hash, data, klass: Game, api: @api, season: self)
          end
        end
      end
    end
  end
end

__END__

sr = Sportradar::Api::Basketball::Nba.new
sd = sr.daily_schedule(Date.new(2017, 1, 21));
g = sd.games.sample

ss = sr.schedule;
