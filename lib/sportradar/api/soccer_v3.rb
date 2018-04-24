# frozen_string_literal: true

module Sportradar
  module Api
    class SoccerV3 < Request
      attr_accessor :league, :access_level, :simulation, :locale
      def initialize(league = 'na', access_level = 't', locale = :en)
        raise Sportradar::Api::Error::InvalidAccessLevel unless allowed_access_levels.include? access_level
        raise Sportradar::Api::Error::InvalidLeague unless allowed_leagues.include? league
        @league = league
        @locale = locale
        @access_level = access_level
      end

      # def schedule
      #   response = get request_url("matches/schedule")
      #   if response.success?
      #     Sportradar::Api::SoccerV3::Schedule.new response
      #   else
      #     response
      #   end
      # end

      def tournaments
        response = get request_url('tournaments')
        if response.success?
          Sportradar::Api::SoccerV3::Tournaments.new indifferent_access(response)
        else
          response
        end
      end

      def tournament_info(tournament_id = 'sr:tournament:7')
        response = get request_url("tournaments/#{tournament_id}/info")
        if response.success?
          Sportradar::Api::SoccerV3::TournamentInfo.new indifferent_access(response)[:tournament_info]
        else
          response
        end
      end

      def tournament_schedule(tournament_id = 'sr:tournament:7')
        response = get request_url("tournaments/#{tournament_id}/schedule")
        if response.success?
          res_hash = indifferent_access(response)[:tournament_schedule]
          Sportradar::Api::SoccerV3::TournamentSchedule.new res_hash
        else
          response
        end
      end

      def player_profile(player_id = 'sr:player:76632')
        response = get request_url("players/#{player_id}/profile")
        if response.success?
          Sportradar::Api::SoccerV3::Player.new indifferent_access(response)[:player_profile]
        else
          response
        end
      end

      # # date =  Date.parse('2016-07-17')
      # def daily_schedule(date = Date.today)
      #   response = get request_url("matches/#{date_path(date)}/schedule")
      #   if response.success?
      #     Sportradar::Api::SoccerV3::Schedule.new response
      #   else
      #     response
      #   end
      # end

      # def daily_summary(date = Date.today)
      #   response = get request_url("matches/#{date_path(date)}/summary")
      #   if response.success?
      #     Sportradar::Api::SoccerV3::Summary.new response
      #   else
      #     response
      #   end
      # end

      # def daily_boxscore(date = Date.today)
      #   response = get request_url("matches/#{date_path(date)}/boxscore")
      #   if response.success?
      #     Sportradar::Api::SoccerV3::Boxscore.new response
      #   else
      #     response
      #   end
      # end

      # match_id  = "357607e9-87cd-4848-b53e-0485d9c1a3bc"
      def match_summary(match_id)
        # check_simulation(match_id)
        response = get request_url("matches/#{match_id}/summary")
        if response.success?
          Sportradar::Api::SoccerV3::Summary.new indifferent_access(response)[:match_summary]
        else
          response
        end
      end

      # # match_id  = "357607e9-87cd-4848-b53e-0485d9c1a3bc"
      # def match_boxscore(match_id)
      #   check_simulation(match_id)
      #   response = get request_url("matches/#{match_id}/boxscore")
      #   if response.success?
      #     Sportradar::Api::SoccerV3::Boxscore.new response
      #   else
      #     response
      #   end
      # end

      def team_profile(team_id = 'sr:competitor:48')
        response = get request_url("teams/#{team_id}/profile")
        if response.success? && response['team_profile']
          Sportradar::Api::SoccerV3::Team.new indifferent_access(response)[:team_profile]
        else
          response
        end
      end

      # # player_id = "2aeacd39-3f9c-42af-957e-9df8573973c4"
      # def player_profile(player_id)
      #   response = get request_url("players/#{player_id}/profile")
      #   if response.success? && response['profile'] && response['profile']['player']
      #     Sportradar::Api::SoccerV3::Player.new response['profile']['player']
      #   else
      #     response
      #   end
      # end

      # def player_rankings
      #   response = get request_url('players/leader')
      #   if response.success? && response['leaders']
      #     Sportradar::Api::SoccerV3::Ranking.new response['leaders']
      #   else
      #     response
      #   end
      # end

      # def team_hierarchy
      #   response = get request_url('teams/hierarchy')
      #   if response.success? && response['hierarchy']
      #     Sportradar::Api::SoccerV3::Hierarchy.new response['hierarchy']
      #   else
      #     response
      #   end
      # end

      # def team_standings
      #   response = get request_url('teams/standing')
      #   if response.success?
      #     Sportradar::Api::SoccerV3::Standing.new response['standings']
      #   else
      #     response
      #   end
      # end

      def tournment_standings(tournament_id = 'sr:tournament:7')
        response = get request_url("tournaments/#{tournament_id}/standings")
        if response.success? && response['tournament_standings']
          Sportradar::Api::SoccerV3::TournamentStandings.new indifferent_access(response['tournament_standings'])
        else
          response
        end
      end

      def simulation_match
        '22653ed5-0b2c-4e30-b10c-c6d51619b52b'
      end

      private

      def check_simulation(match_id)
        @simulation = true if match_id == simulation_match
      end

      def request_url(path)
        if simulation
          "/soccer-sim2/wc/#{path}"
        else
          "/soccer-#{access_level}#{version}/#{league}/#{locale}/#{path}"
        end
      end

      def api_key
        if access_level == 'p'
          Sportradar::Api.api_key_params("soccerv3_#{league}", 'production')
        else
          Sportradar::Api.api_key_params("soccerv3_#{league}")
        end
      end

      def version
        Sportradar::Api.version('soccerv3')
      end

      def allowed_access_levels
        %w[p t xt]
      end

      def allowed_leagues
        %w[eu na sa wc as af other]
      end
    end
  end
end
