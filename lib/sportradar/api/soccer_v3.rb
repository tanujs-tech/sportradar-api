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
        res = {"tournament"=>{"sport"=>{"id"=>"sr:sport:1", "name"=>"Soccer"}, "category"=>{"id"=>"sr:category:393", "name"=>"International Clubs"}, "current_season"=>{"id"=>"sr:season:41198", "name"=>"UEFA Champions League 17/18", "start_date"=>"2017-06-27", "end_date"=>"2018-05-27", "year"=>"17/18"}, "id"=>"sr:tournament:7", "name"=>"UEFA Champions League"}, "season"=>{"id"=>"sr:season:41198", "name"=>"UEFA Champions League 17/18", "start_date"=>"2017-06-27", "end_date"=>"2018-05-27", "year"=>"17/18", "tournament_id"=>"sr:tournament:7"}, "standings"=>[{"group"=>[{"team_standing"=>[{"team"=>{"id"=>"sr:competitor:35", "name"=>"Manchester United"}, "rank"=>"1", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"5", "draw"=>"0", "loss"=>"1", "goals_for"=>"12", "goals_against"=>"3", "goal_diff"=>"9", "points"=>"15"}, {"team"=>{"id"=>"sr:competitor:2501", "name"=>"FC Basel"}, "rank"=>"2", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"4", "draw"=>"0", "loss"=>"2", "goals_for"=>"11", "goals_against"=>"5", "goal_diff"=>"6", "points"=>"12"}, {"team"=>{"id"=>"sr:competitor:2325", "name"=>"CSKA Moscow"}, "rank"=>"3", "current_outcome"=>"Europa League", "played"=>"6", "win"=>"3", "draw"=>"0", "loss"=>"3", "goals_for"=>"8", "goals_against"=>"10", "goal_diff"=>"-2", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:3006", "name"=>"Benfica Lisbon"}, "rank"=>"4", "played"=>"6", "win"=>"0", "draw"=>"0", "loss"=>"6", "goals_for"=>"1", "goals_against"=>"14", "goal_diff"=>"-13", "points"=>"0"}], "name"=>"A"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:1644", "name"=>"Paris Saint-Germain"}, "rank"=>"1", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"5", "draw"=>"0", "loss"=>"1", "goals_for"=>"25", "goals_against"=>"4", "goal_diff"=>"21", "points"=>"15"}, {"team"=>{"id"=>"sr:competitor:2672", "name"=>"Bayern Munich"}, "rank"=>"2", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"5", "draw"=>"0", "loss"=>"1", "goals_for"=>"13", "goals_against"=>"6", "goal_diff"=>"7", "points"=>"15"}, {"team"=>{"id"=>"sr:competitor:2352", "name"=>"Celtic FC"}, "rank"=>"3", "current_outcome"=>"Europa League", "played"=>"6", "win"=>"1", "draw"=>"0", "loss"=>"5", "goals_for"=>"5", "goals_against"=>"18", "goal_diff"=>"-13", "points"=>"3"}, {"team"=>{"id"=>"sr:competitor:2900", "name"=>"RSC Anderlecht"}, "rank"=>"4", "played"=>"6", "win"=>"1", "draw"=>"0", "loss"=>"5", "goals_for"=>"2", "goals_against"=>"17", "goal_diff"=>"-15", "points"=>"3"}], "name"=>"B"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:2702", "name"=>"AS Roma"}, "rank"=>"1", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"3", "draw"=>"2", "loss"=>"1", "goals_for"=>"9", "goals_against"=>"6", "goal_diff"=>"3", "points"=>"11"}, {"team"=>{"id"=>"sr:competitor:38", "name"=>"Chelsea FC"}, "rank"=>"2", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"3", "draw"=>"2", "loss"=>"1", "goals_for"=>"16", "goals_against"=>"8", "goal_diff"=>"8", "points"=>"11"}, {"team"=>{"id"=>"sr:competitor:2836", "name"=>"Atletico Madrid"}, "rank"=>"3", "current_outcome"=>"Europa League", "played"=>"6", "win"=>"1", "draw"=>"4", "loss"=>"1", "goals_for"=>"5", "goals_against"=>"4", "goal_diff"=>"1", "points"=>"7"}, {"team"=>{"id"=>"sr:competitor:5962", "name"=>"Qarabag FK"}, "rank"=>"4", "played"=>"6", "win"=>"0", "draw"=>"2", "loss"=>"4", "goals_for"=>"2", "goals_against"=>"14", "goal_diff"=>"-12", "points"=>"2"}], "name"=>"C"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:2817", "name"=>"FC Barcelona"}, "rank"=>"1", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"4", "draw"=>"2", "loss"=>"0", "goals_for"=>"9", "goals_against"=>"1", "goal_diff"=>"8", "points"=>"14"}, {"team"=>{"id"=>"sr:competitor:2687", "name"=>"Juventus Turin"}, "rank"=>"2", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"3", "draw"=>"2", "loss"=>"1", "goals_for"=>"7", "goals_against"=>"5", "goal_diff"=>"2", "points"=>"11"}, {"team"=>{"id"=>"sr:competitor:3001", "name"=>"Sporting CP"}, "rank"=>"3", "current_outcome"=>"Europa League", "played"=>"6", "win"=>"2", "draw"=>"1", "loss"=>"3", "goals_for"=>"8", "goals_against"=>"9", "goal_diff"=>"-1", "points"=>"7"}, {"team"=>{"id"=>"sr:competitor:3245", "name"=>"Olympiacos FC"}, "rank"=>"4", "played"=>"6", "win"=>"0", "draw"=>"1", "loss"=>"5", "goals_for"=>"4", "goals_against"=>"13", "goal_diff"=>"-9", "points"=>"1"}], "name"=>"D"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:44", "name"=>"Liverpool FC"}, "rank"=>"1", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"3", "draw"=>"3", "loss"=>"0", "goals_for"=>"23", "goals_against"=>"6", "goal_diff"=>"17", "points"=>"12"}, {"team"=>{"id"=>"sr:competitor:2833", "name"=>"Sevilla FC"}, "rank"=>"2", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"2", "draw"=>"3", "loss"=>"1", "goals_for"=>"12", "goals_against"=>"12", "goal_diff"=>"0", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:2323", "name"=>"FC Spartak Moscow"}, "rank"=>"3", "current_outcome"=>"Europa League", "played"=>"6", "win"=>"1", "draw"=>"3", "loss"=>"2", "goals_for"=>"9", "goals_against"=>"13", "goal_diff"=>"-4", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2420", "name"=>"NK Maribor"}, "rank"=>"4", "played"=>"6", "win"=>"0", "draw"=>"3", "loss"=>"3", "goals_for"=>"3", "goals_against"=>"16", "goal_diff"=>"-13", "points"=>"3"}], "name"=>"E"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:17", "name"=>"Manchester City"}, "rank"=>"1", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"5", "draw"=>"0", "loss"=>"1", "goals_for"=>"14", "goals_against"=>"5", "goal_diff"=>"9", "points"=>"15"}, {"team"=>{"id"=>"sr:competitor:3313", "name"=>"FC Shakhtar Donetsk"}, "rank"=>"2", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"4", "draw"=>"0", "loss"=>"2", "goals_for"=>"9", "goals_against"=>"9", "goal_diff"=>"0", "points"=>"12"}, {"team"=>{"id"=>"sr:competitor:2714", "name"=>"SSC Napoli"}, "rank"=>"3", "current_outcome"=>"Europa League", "played"=>"6", "win"=>"2", "draw"=>"0", "loss"=>"4", "goals_for"=>"11", "goals_against"=>"11", "goal_diff"=>"0", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2959", "name"=>"Feyenoord Rotterdam"}, "rank"=>"4", "played"=>"6", "win"=>"1", "draw"=>"0", "loss"=>"5", "goals_for"=>"5", "goals_against"=>"14", "goal_diff"=>"-9", "points"=>"3"}], "name"=>"F"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:3050", "name"=>"Besiktas JK"}, "rank"=>"1", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"4", "draw"=>"2", "loss"=>"0", "goals_for"=>"11", "goals_against"=>"5", "goal_diff"=>"6", "points"=>"14"}, {"team"=>{"id"=>"sr:competitor:3002", "name"=>"FC Porto"}, "rank"=>"2", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"3", "draw"=>"1", "loss"=>"2", "goals_for"=>"15", "goals_against"=>"10", "goal_diff"=>"5", "points"=>"10"}, {"team"=>{"id"=>"sr:competitor:36360", "name"=>"RB Leipzig"}, "rank"=>"3", "current_outcome"=>"Europa League", "played"=>"6", "win"=>"2", "draw"=>"1", "loss"=>"3", "goals_for"=>"10", "goals_against"=>"11", "goal_diff"=>"-1", "points"=>"7"}, {"team"=>{"id"=>"sr:competitor:1653", "name"=>"AS Monaco"}, "rank"=>"4", "played"=>"6", "win"=>"0", "draw"=>"2", "loss"=>"4", "goals_for"=>"6", "goals_against"=>"16", "goal_diff"=>"-10", "points"=>"2"}], "name"=>"G"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:33", "name"=>"Tottenham Hotspur"}, "rank"=>"1", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"5", "draw"=>"1", "loss"=>"0", "goals_for"=>"15", "goals_against"=>"4", "goal_diff"=>"11", "points"=>"16"}, {"team"=>{"id"=>"sr:competitor:2829", "name"=>"Real Madrid"}, "rank"=>"2", "current_outcome"=>"Playoffs", "played"=>"6", "win"=>"4", "draw"=>"1", "loss"=>"1", "goals_for"=>"17", "goals_against"=>"7", "goal_diff"=>"10", "points"=>"13"}, {"team"=>{"id"=>"sr:competitor:2673", "name"=>"Borussia Dortmund"}, "rank"=>"3", "current_outcome"=>"Europa League", "played"=>"6", "win"=>"0", "draw"=>"2", "loss"=>"4", "goals_for"=>"7", "goals_against"=>"13", "goal_diff"=>"-6", "points"=>"2"}, {"team"=>{"id"=>"sr:competitor:3398", "name"=>"Apoel Nicosia FC"}, "rank"=>"4", "played"=>"6", "win"=>"0", "draw"=>"2", "loss"=>"4", "goals_for"=>"2", "goals_against"=>"17", "goal_diff"=>"-15", "points"=>"2"}], "name"=>"H"}], "tie_break_rule"=>"At the end of the group phase, in the event that two (or more) teams have an equal number of points the following rules break the tie:\r\n1. Head-to-head\r\n2. Goal difference\r\n3. Goals scored\r\nDuring the group phase, the following tie-breaking procedures are used:\r\n1. Goal difference\r\n2. Goals scored", "type"=>"total"}, {"group"=>[{"team_standing"=>[{"team"=>{"id"=>"sr:competitor:35", "name"=>"Manchester United"}, "rank"=>"1", "played"=>"3", "win"=>"3", "draw"=>"0", "loss"=>"0", "goals_for"=>"7", "goals_against"=>"1", "goal_diff"=>"6", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:2501", "name"=>"FC Basel"}, "rank"=>"2", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"7", "goals_against"=>"2", "goal_diff"=>"5", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2325", "name"=>"CSKA Moscow"}, "rank"=>"3", "played"=>"3", "win"=>"1", "draw"=>"0", "loss"=>"2", "goals_for"=>"3", "goals_against"=>"6", "goal_diff"=>"-3", "points"=>"3"}, {"team"=>{"id"=>"sr:competitor:3006", "name"=>"Benfica Lisbon"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"0", "loss"=>"3", "goals_for"=>"1", "goals_against"=>"5", "goal_diff"=>"-4", "points"=>"0"}], "name"=>"A"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:1644", "name"=>"Paris Saint-Germain"}, "rank"=>"1", "played"=>"3", "win"=>"3", "draw"=>"0", "loss"=>"0", "goals_for"=>"15", "goals_against"=>"1", "goal_diff"=>"14", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:2672", "name"=>"Bayern Munich"}, "rank"=>"2", "played"=>"3", "win"=>"3", "draw"=>"0", "loss"=>"0", "goals_for"=>"9", "goals_against"=>"1", "goal_diff"=>"8", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:2352", "name"=>"Celtic FC"}, "rank"=>"3", "played"=>"3", "win"=>"0", "draw"=>"0", "loss"=>"3", "goals_for"=>"1", "goals_against"=>"8", "goal_diff"=>"-7", "points"=>"0"}, {"team"=>{"id"=>"sr:competitor:2900", "name"=>"RSC Anderlecht"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"0", "loss"=>"3", "goals_for"=>"1", "goals_against"=>"9", "goal_diff"=>"-8", "points"=>"0"}], "name"=>"B"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:2702", "name"=>"AS Roma"}, "rank"=>"1", "played"=>"3", "win"=>"2", "draw"=>"1", "loss"=>"0", "goals_for"=>"4", "goals_against"=>"0", "goal_diff"=>"4", "points"=>"7"}, {"team"=>{"id"=>"sr:competitor:38", "name"=>"Chelsea FC"}, "rank"=>"2", "played"=>"3", "win"=>"1", "draw"=>"2", "loss"=>"0", "goals_for"=>"10", "goals_against"=>"4", "goal_diff"=>"6", "points"=>"5"}, {"team"=>{"id"=>"sr:competitor:2836", "name"=>"Atletico Madrid"}, "rank"=>"3", "played"=>"3", "win"=>"1", "draw"=>"1", "loss"=>"1", "goals_for"=>"4", "goals_against"=>"3", "goal_diff"=>"1", "points"=>"4"}, {"team"=>{"id"=>"sr:competitor:5962", "name"=>"Qarabag FK"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"1", "loss"=>"2", "goals_for"=>"1", "goals_against"=>"6", "goal_diff"=>"-5", "points"=>"1"}], "name"=>"C"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:2817", "name"=>"FC Barcelona"}, "rank"=>"1", "played"=>"3", "win"=>"3", "draw"=>"0", "loss"=>"0", "goals_for"=>"8", "goals_against"=>"1", "goal_diff"=>"7", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:2687", "name"=>"Juventus Turin"}, "rank"=>"2", "played"=>"3", "win"=>"2", "draw"=>"1", "loss"=>"0", "goals_for"=>"4", "goals_against"=>"1", "goal_diff"=>"3", "points"=>"7"}, {"team"=>{"id"=>"sr:competitor:3001", "name"=>"Sporting CP"}, "rank"=>"3", "played"=>"3", "win"=>"1", "draw"=>"1", "loss"=>"1", "goals_for"=>"4", "goals_against"=>"3", "goal_diff"=>"1", "points"=>"4"}, {"team"=>{"id"=>"sr:competitor:3245", "name"=>"Olympiacos FC"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"1", "loss"=>"2", "goals_for"=>"2", "goals_against"=>"5", "goal_diff"=>"-3", "points"=>"1"}], "name"=>"D"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:2833", "name"=>"Sevilla FC"}, "rank"=>"1", "played"=>"3", "win"=>"2", "draw"=>"1", "loss"=>"0", "goals_for"=>"8", "goals_against"=>"4", "goal_diff"=>"4", "points"=>"7"}, {"team"=>{"id"=>"sr:competitor:44", "name"=>"Liverpool FC"}, "rank"=>"2", "played"=>"3", "win"=>"2", "draw"=>"1", "loss"=>"0", "goals_for"=>"12", "goals_against"=>"2", "goal_diff"=>"10", "points"=>"7"}, {"team"=>{"id"=>"sr:competitor:2323", "name"=>"FC Spartak Moscow"}, "rank"=>"3", "played"=>"3", "win"=>"1", "draw"=>"2", "loss"=>"0", "goals_for"=>"7", "goals_against"=>"3", "goal_diff"=>"4", "points"=>"5"}, {"team"=>{"id"=>"sr:competitor:2420", "name"=>"NK Maribor"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"2", "loss"=>"1", "goals_for"=>"2", "goals_against"=>"9", "goal_diff"=>"-7", "points"=>"2"}], "name"=>"E"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:17", "name"=>"Manchester City"}, "rank"=>"1", "played"=>"3", "win"=>"3", "draw"=>"0", "loss"=>"0", "goals_for"=>"5", "goals_against"=>"1", "goal_diff"=>"4", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:3313", "name"=>"FC Shakhtar Donetsk"}, "rank"=>"2", "played"=>"3", "win"=>"3", "draw"=>"0", "loss"=>"0", "goals_for"=>"7", "goals_against"=>"3", "goal_diff"=>"4", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:2714", "name"=>"SSC Napoli"}, "rank"=>"3", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"8", "goals_against"=>"5", "goal_diff"=>"3", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2959", "name"=>"Feyenoord Rotterdam"}, "rank"=>"4", "played"=>"3", "win"=>"1", "draw"=>"0", "loss"=>"2", "goals_for"=>"3", "goals_against"=>"7", "goal_diff"=>"-4", "points"=>"3"}], "name"=>"F"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:3002", "name"=>"FC Porto"}, "rank"=>"1", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"9", "goals_against"=>"6", "goal_diff"=>"3", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:3050", "name"=>"Besiktas JK"}, "rank"=>"2", "played"=>"3", "win"=>"1", "draw"=>"2", "loss"=>"0", "goals_for"=>"4", "goals_against"=>"2", "goal_diff"=>"2", "points"=>"5"}, {"team"=>{"id"=>"sr:competitor:36360", "name"=>"RB Leipzig"}, "rank"=>"3", "played"=>"3", "win"=>"1", "draw"=>"1", "loss"=>"1", "goals_for"=>"5", "goals_against"=>"5", "goal_diff"=>"0", "points"=>"4"}, {"team"=>{"id"=>"sr:competitor:1653", "name"=>"AS Monaco"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"0", "loss"=>"3", "goals_for"=>"2", "goals_against"=>"9", "goal_diff"=>"-7", "points"=>"0"}], "name"=>"G"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:33", "name"=>"Tottenham Hotspur"}, "rank"=>"1", "played"=>"3", "win"=>"3", "draw"=>"0", "loss"=>"0", "goals_for"=>"9", "goals_against"=>"2", "goal_diff"=>"7", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:2829", "name"=>"Real Madrid"}, "rank"=>"2", "played"=>"3", "win"=>"2", "draw"=>"1", "loss"=>"0", "goals_for"=>"7", "goals_against"=>"3", "goal_diff"=>"4", "points"=>"7"}, {"team"=>{"id"=>"sr:competitor:2673", "name"=>"Borussia Dortmund"}, "rank"=>"3", "played"=>"3", "win"=>"0", "draw"=>"1", "loss"=>"2", "goals_for"=>"3", "goals_against"=>"6", "goal_diff"=>"-3", "points"=>"1"}, {"team"=>{"id"=>"sr:competitor:3398", "name"=>"Apoel Nicosia FC"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"1", "loss"=>"2", "goals_for"=>"1", "goals_against"=>"10", "goal_diff"=>"-9", "points"=>"1"}], "name"=>"H"}], "tie_break_rule"=>"At the end of the group phase, in the event that two (or more) teams have an equal number of points the following rules break the tie:\r\n1. Head-to-head\r\n2. Goal difference\r\n3. Goals scored\r\nDuring the group phase, the following tie-breaking procedures are used:\r\n1. Goal difference\r\n2. Goals scored", "type"=>"home"}, {"group"=>[{"team_standing"=>[{"team"=>{"id"=>"sr:competitor:35", "name"=>"Manchester United"}, "rank"=>"1", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"5", "goals_against"=>"2", "goal_diff"=>"3", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2325", "name"=>"CSKA Moscow"}, "rank"=>"2", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"5", "goals_against"=>"4", "goal_diff"=>"1", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2501", "name"=>"FC Basel"}, "rank"=>"3", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"4", "goals_against"=>"3", "goal_diff"=>"1", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:3006", "name"=>"Benfica Lisbon"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"0", "loss"=>"3", "goals_for"=>"0", "goals_against"=>"9", "goal_diff"=>"-9", "points"=>"0"}], "name"=>"A"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:1644", "name"=>"Paris Saint-Germain"}, "rank"=>"1", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"10", "goals_against"=>"3", "goal_diff"=>"7", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2672", "name"=>"Bayern Munich"}, "rank"=>"2", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"4", "goals_against"=>"5", "goal_diff"=>"-1", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2352", "name"=>"Celtic FC"}, "rank"=>"3", "played"=>"3", "win"=>"1", "draw"=>"0", "loss"=>"2", "goals_for"=>"4", "goals_against"=>"10", "goal_diff"=>"-6", "points"=>"3"}, {"team"=>{"id"=>"sr:competitor:2900", "name"=>"RSC Anderlecht"}, "rank"=>"4", "played"=>"3", "win"=>"1", "draw"=>"0", "loss"=>"2", "goals_for"=>"1", "goals_against"=>"8", "goal_diff"=>"-7", "points"=>"3"}], "name"=>"B"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:38", "name"=>"Chelsea FC"}, "rank"=>"1", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"6", "goals_against"=>"4", "goal_diff"=>"2", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2702", "name"=>"AS Roma"}, "rank"=>"2", "played"=>"3", "win"=>"1", "draw"=>"1", "loss"=>"1", "goals_for"=>"5", "goals_against"=>"6", "goal_diff"=>"-1", "points"=>"4"}, {"team"=>{"id"=>"sr:competitor:2836", "name"=>"Atletico Madrid"}, "rank"=>"3", "played"=>"3", "win"=>"0", "draw"=>"3", "loss"=>"0", "goals_for"=>"1", "goals_against"=>"1", "goal_diff"=>"0", "points"=>"3"}, {"team"=>{"id"=>"sr:competitor:5962", "name"=>"Qarabag FK"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"1", "loss"=>"2", "goals_for"=>"1", "goals_against"=>"8", "goal_diff"=>"-7", "points"=>"1"}], "name"=>"C"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:2817", "name"=>"FC Barcelona"}, "rank"=>"1", "played"=>"3", "win"=>"1", "draw"=>"2", "loss"=>"0", "goals_for"=>"1", "goals_against"=>"0", "goal_diff"=>"1", "points"=>"5"}, {"team"=>{"id"=>"sr:competitor:2687", "name"=>"Juventus Turin"}, "rank"=>"2", "played"=>"3", "win"=>"1", "draw"=>"1", "loss"=>"1", "goals_for"=>"3", "goals_against"=>"4", "goal_diff"=>"-1", "points"=>"4"}, {"team"=>{"id"=>"sr:competitor:3001", "name"=>"Sporting CP"}, "rank"=>"3", "played"=>"3", "win"=>"1", "draw"=>"0", "loss"=>"2", "goals_for"=>"4", "goals_against"=>"6", "goal_diff"=>"-2", "points"=>"3"}, {"team"=>{"id"=>"sr:competitor:3245", "name"=>"Olympiacos FC"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"0", "loss"=>"3", "goals_for"=>"2", "goals_against"=>"8", "goal_diff"=>"-6", "points"=>"0"}], "name"=>"D"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:44", "name"=>"Liverpool FC"}, "rank"=>"1", "played"=>"3", "win"=>"1", "draw"=>"2", "loss"=>"0", "goals_for"=>"11", "goals_against"=>"4", "goal_diff"=>"7", "points"=>"5"}, {"team"=>{"id"=>"sr:competitor:2833", "name"=>"Sevilla FC"}, "rank"=>"2", "played"=>"3", "win"=>"0", "draw"=>"2", "loss"=>"1", "goals_for"=>"4", "goals_against"=>"8", "goal_diff"=>"-4", "points"=>"2"}, {"team"=>{"id"=>"sr:competitor:2420", "name"=>"NK Maribor"}, "rank"=>"3", "played"=>"3", "win"=>"0", "draw"=>"1", "loss"=>"2", "goals_for"=>"1", "goals_against"=>"7", "goal_diff"=>"-6", "points"=>"1"}, {"team"=>{"id"=>"sr:competitor:2323", "name"=>"FC Spartak Moscow"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"1", "loss"=>"2", "goals_for"=>"2", "goals_against"=>"10", "goal_diff"=>"-8", "points"=>"1"}], "name"=>"E"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:17", "name"=>"Manchester City"}, "rank"=>"1", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"9", "goals_against"=>"4", "goal_diff"=>"5", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:3313", "name"=>"FC Shakhtar Donetsk"}, "rank"=>"2", "played"=>"3", "win"=>"1", "draw"=>"0", "loss"=>"2", "goals_for"=>"2", "goals_against"=>"6", "goal_diff"=>"-4", "points"=>"3"}, {"team"=>{"id"=>"sr:competitor:2714", "name"=>"SSC Napoli"}, "rank"=>"3", "played"=>"3", "win"=>"0", "draw"=>"0", "loss"=>"3", "goals_for"=>"3", "goals_against"=>"6", "goal_diff"=>"-3", "points"=>"0"}, {"team"=>{"id"=>"sr:competitor:2959", "name"=>"Feyenoord Rotterdam"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"0", "loss"=>"3", "goals_for"=>"2", "goals_against"=>"7", "goal_diff"=>"-5", "points"=>"0"}], "name"=>"F"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:3050", "name"=>"Besiktas JK"}, "rank"=>"1", "played"=>"3", "win"=>"3", "draw"=>"0", "loss"=>"0", "goals_for"=>"7", "goals_against"=>"3", "goal_diff"=>"4", "points"=>"9"}, {"team"=>{"id"=>"sr:competitor:3002", "name"=>"FC Porto"}, "rank"=>"2", "played"=>"3", "win"=>"1", "draw"=>"1", "loss"=>"1", "goals_for"=>"6", "goals_against"=>"4", "goal_diff"=>"2", "points"=>"4"}, {"team"=>{"id"=>"sr:competitor:36360", "name"=>"RB Leipzig"}, "rank"=>"3", "played"=>"3", "win"=>"1", "draw"=>"0", "loss"=>"2", "goals_for"=>"5", "goals_against"=>"6", "goal_diff"=>"-1", "points"=>"3"}, {"team"=>{"id"=>"sr:competitor:1653", "name"=>"AS Monaco"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"2", "loss"=>"1", "goals_for"=>"4", "goals_against"=>"7", "goal_diff"=>"-3", "points"=>"2"}], "name"=>"G"}, {"team_standing"=>[{"team"=>{"id"=>"sr:competitor:33", "name"=>"Tottenham Hotspur"}, "rank"=>"1", "played"=>"3", "win"=>"2", "draw"=>"1", "loss"=>"0", "goals_for"=>"6", "goals_against"=>"2", "goal_diff"=>"4", "points"=>"7"}, {"team"=>{"id"=>"sr:competitor:2829", "name"=>"Real Madrid"}, "rank"=>"2", "played"=>"3", "win"=>"2", "draw"=>"0", "loss"=>"1", "goals_for"=>"10", "goals_against"=>"4", "goal_diff"=>"6", "points"=>"6"}, {"team"=>{"id"=>"sr:competitor:2673", "name"=>"Borussia Dortmund"}, "rank"=>"3", "played"=>"3", "win"=>"0", "draw"=>"1", "loss"=>"2", "goals_for"=>"4", "goals_against"=>"7", "goal_diff"=>"-3", "points"=>"1"}, {"team"=>{"id"=>"sr:competitor:3398", "name"=>"Apoel Nicosia FC"}, "rank"=>"4", "played"=>"3", "win"=>"0", "draw"=>"1", "loss"=>"2", "goals_for"=>"1", "goals_against"=>"7", "goal_diff"=>"-6", "points"=>"1"}], "name"=>"H"}], "tie_break_rule"=>"At the end of the group phase, in the event that two (or more) teams have an equal number of points the following rules break the tie:\r\n1. Head-to-head\r\n2. Goal difference\r\n3. Goals scored\r\nDuring the group phase, the following tie-breaking procedures are used:\r\n1. Goal difference\r\n2. Goals scored", "type"=>"away"}], "generated_at"=>"2018-04-24T09:48:40+00:00", "schemaLocation"=>"http://schemas.sportradar.com/sportsapi/v1/soccer http://schemas.sportradar.com/bsa/soccer/v1/xml/endpoints/soccer/tournament_standings.xsd"}
        Sportradar::Api::SoccerV3::TournamentStandings.new indifferent_access(res)

        # response = get request_url("tournaments/#{tournament_id}/standings")
        # if response.success? && response['tournament_standings']
        #   Sportradar::Api::SoccerV3::TournamentStandings.new indifferent_access(response['tournament_standings'])
        # else
        #   response
        # end
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
