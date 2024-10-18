# frozen_string_literal: true

require 'way_of_working'
require_relative 'hdi/paths'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem_extension(WayOfWorking::CodeLinting)
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
