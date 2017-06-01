# frozen_string_literal: true

module Sportradar
  module Api
    module Basketball
      class ThreePointMiss < ShotMiss
        def display_type
          '3PT Miss'
        end
      end
    end
  end
end
