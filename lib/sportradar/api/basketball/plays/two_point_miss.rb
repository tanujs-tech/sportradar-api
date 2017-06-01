# frozen_string_literal: true

module Sportradar
  module Api
    module Basketball
      class TwoPointMiss < ShotMiss
        def display_type
          '2PT Miss'
        end
      end
    end
  end
end
