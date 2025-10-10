# frozen_string_literal: true

require 'active_support'

module WayOfWorking
  module CodeLinting
    module Hdi
      module Generators
        # This concern provides methods to get GitHub metadata
        module GithubMetadata
          extend ActiveSupport::Concern

          private

          def code_standards_team
            'code-standards-team'
          end

          def github_organisation
            @github_organisation ||= begin
              remote_url = `git -C #{destination_root} remote get-url origin`.strip
              matchdata = remote_url.match(%r{github\.com[:/]([^/]+)/})
              matchdata[1] if matchdata
            end
          end
        end
      end
    end
  end
end
