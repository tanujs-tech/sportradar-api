# frozen_string_literal: true

module Sportradar
  module Api
    module Basketball
      class OfficialTimeout < Timeout
        def display_type
          'Timeout'
        end
      end
    end
  end
end
