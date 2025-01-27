# frozen_string_literal: true

require 'way_of_working'
require_relative 'hdi/paths'
require 'zeitwerk'

# If way_of_working-audit-github is used we can add a rule
begin
  require 'way_of_working/audit/github/rules/registry'
  require_relative 'hdi/github_audit_rule'
rescue LoadError # rubocop:disable Lint/SuppressedException
end

loader = Zeitwerk::Loader.for_gem_extension(WayOfWorking::CodeLinting)
loader.ignore("#{__dir__}/hdi/plugin.rb")
loader.setup

module WayOfWorking
  module CodeLinting
    module Hdi
      class Error < StandardError; end
    end
  end

  module SubCommands
    # This reopens the "way_of_working exec" sub command
    class Exec
      register(CodeLinting::Hdi::Generators::Exec, 'code_linting', 'code_linting',
               <<~LONGDESC)
                 Description:
                     This runs code linting on this project

                 Example:
                     way_of_working exec code_linting
               LONGDESC
    end

    # This reopens the "way_of_working init" sub command
    class Init
      register(CodeLinting::Hdi::Generators::Init, 'code_linting', 'code_linting',
               <<~LONGDESC)
                 Description:
                     Installs code linting config files into the project

                 Example:
                     way_of_working init code_linting

                     This will create:
                         .github/workflows/mega-linter.yml
                         .mega-linter.yml
               LONGDESC
    end
  end
end
