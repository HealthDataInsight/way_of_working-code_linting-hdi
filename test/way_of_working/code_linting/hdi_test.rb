# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  module CodeLinting
    class HdiTest < Minitest::Test
      def test_that_it_has_a_version_number
        refute_nil ::WayOfWorking::CodeLinting::Hdi::VERSION
      end
    end
  end
end
