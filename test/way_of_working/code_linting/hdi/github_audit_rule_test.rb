# frozen_string_literal: true

require 'test_helper'

module WayOfWorking
  module CodeLinting
    module Hdi
      class GithubAuditRuleTest < Minitest::Test
        def test_the_rule_is_registered
          # way_of_working (>= 2.1) ships the GitHub audit framework, so requiring the
          # plugin auto-registers this rule against the real registry (see hdi.rb).
          assert ::WayOfWorking::Audit::Github::Rules::Registry.rules.values.include?(GithubAuditRule)
          assert_equal [:way_of_working], GithubAuditRule.tags
        end
      end
    end
  end
end
