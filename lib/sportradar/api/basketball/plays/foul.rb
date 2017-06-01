# frozen_string_literal: true

module Sportradar
  module Api
    module Basketball
      class Foul < Play::Base
        def base_key
          'personalfoul'
        end

        def display_type
          'Foul'
        end

        def foul_type(_data)
          @event_type
        end
      end
    end
  end
end
