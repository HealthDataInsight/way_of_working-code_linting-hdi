# frozen_string_literal: true

require 'way_of_working/github_audit/rules/base'

module WayOfWorking
  module CodeLinting
    # The namespace for this plugin
    module Hdi
      # This rule checks for the MegaLinter workflow action and README badge.
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        def valid?
          response = @client.workflows(@repo_name)

          @errors << 'No MegaLinter GitHub Action' unless response.workflows.map(&:name).include?('MegaLinter')

          @errors << 'No MegaLinter README Badge' unless megalinter_badge?

          @errors.empty? ? :passed : :failed
        end

        private

        def megalinter_badge?
          readme_content.include?("[![MegaLinter](https://github.com/#{@repo_name}/workflows/MegaLinter/badge.svg")
        end
      end

      ::WayOfWorking::Audit::Github::Rules::Registry.register(GithubActionAndBadge,
                                                              'MegaLinter GitHub Action and README badge')
    end
  end
end
