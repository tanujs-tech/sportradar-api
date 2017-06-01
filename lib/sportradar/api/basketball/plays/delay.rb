# frozen_string_literal: true

module Sportradar
  module Api
    module Basketball
      class Delay < Play::Base
        def display_type
          'Delay'
        end
      end
    end
  end
end
