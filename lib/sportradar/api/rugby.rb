# frozen_string_literal: true

module Sportradar
  module Api
    class Rugby < Request
      attr_accessor :access_level, :simulation, :locale
      
      def initialize(access_level = 't', locale = :en)
        puts "hello"
        raise Sportradar::Api::Error::InvalidAccessLevel unless allowed_access_levels.include? access_level
        @locale = locale
        @access_level = access_level
      end

      def schedule
        response = get request_url("matches/#{Date.today.year}/schedule")
        if response.success?
          response.parsed_response
        else
          response
        end
      end

      def standings
        response = get request_url("teams/#{Date.today.year}/standings")
        if response.success?
          response.parsed_response
        else
          response
        end
      end
    
      def daily_schedule(date = Date.today)
        response = get request_url("matches/#{date_path(date)}/schedule")
        if response.success?
          response.parsed_response
        else
          response
        end
      end

      def daily_summary(date = Date.today)
        response = get request_url("matches/#{date_path(date)}/summary")
        if response.success?
          response.parsed_response
        else
          response
        end
      end

      def daily_boxscore(date = Date.today)
        response = get request_url("matches/#{date_path(date)}/boxscore")
        if response.success?
          response.parsed_response
        else
          response
        end
      end

      def league_hierarchy(date = Date.today)
        response = get request_url("teams/#{date.year}/hierarchy")
        if response.success?
          response.parsed_response
        else
          response
        end
      end

      def match_boxscore(match_id = '2fadc372-1bc2-4b13-af76-85997e0c389f')
        response = get request_url("matches/#{match_id}/boxscore")
        if response.success?
          response.parsed_response
        else
          response
        end
      end

      def match_summary(match_id = '2fadc372-1bc2-4b13-af76-85997e0c389f')
        response = get request_url("matches/#{match_id}/summary")
        if response.success?
          response.parsed_response
        else
          response
        end
      end
     

      def team_profile(team_id = '140a99-5b41-400d-b189-5c098b753b3d')
        response = get request_url("teams/#{team_id}/profile")
        if response.success?
          response.parsed_response
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
        "/rugby-#{access_level}#{version}/#{path}"
      end
      def api_key
        if access_level == 'p'
          Sportradar::Api.api_key_params("rugby", 'production')
        else
          Sportradar::Api.api_key_params("rugby")
        end
      end

      def version
        Sportradar::Api.version('rugby')
      end

      def allowed_access_levels
        %w[p t]
      end
    end
  end
end
