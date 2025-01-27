# frozen_string_literal: true

require 'way_of_working/audit/github/rules/base'

module WayOfWorking
  module CodeLinting
    # The namespace for this plugin
    module Hdi
      # This rule checks for the MegaLinter workflow action and README badge.
      class GithubAuditRule < ::WayOfWorking::Audit::Github::Rules::Base
        source_root WayOfWorking::CodeLinting::Hdi.source_root

        def validate
          workflows = @client.workflows(@repo_name).workflows
          @errors << 'No HDI MegaLinter GitHub Action' unless workflows.map(&:name).include?('MegaLinter')

          @errors << 'No HDI MegaLinter README Badge' unless megalinter_badge?

          validate_repo_file_contains_source_file(
            '.github/linters/rubocop_defaults.yml',
            '.mega-linter.yml',
            '.rubocop'
          )
        end

        private

        def repo_file_contains_source_file?(path)
          repo_file_contains?(path, File.read(self.class.source_root.join(path)))
        end

        def repo_file_contains?(path, text)
          remote_content = repo_file_contents(path)
          return false if remote_content.nil?

          remote_content.include?(text)
        end

        def validate_repo_file_contains_source_file(*paths)
          paths.each do |path|
            if repo_file_contents(path).nil?
              @errors << "#{path} missing"
              next
            end

            @errors << "#{path} does not match the source template" unless repo_file_contains_source_file?(path)
          end
        end

        def megalinter_badge?
          readme_content.include?("[![MegaLinter](https://github.com/#{@repo_name}/workflows/MegaLinter/badge.svg")
        end
      end

      ::WayOfWorking::Audit::Github::Rules::Registry.register(
        GithubAuditRule, 'HDI MegaLinter GitHub Action and README badge'
      )
    end
  end
end
