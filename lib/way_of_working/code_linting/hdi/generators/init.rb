# frozen_string_literal: true

require 'thor'
require 'way_of_working/paths'

module WayOfWorking
  module CodeLinting
    module Hdi
      module Generators
        # This generator initialises the linter
        class Init < Thor::Group
          # include Thor::Actions

          # Intialise the linters
          invoke InitLinters

          # Document the linters
          invoke DocumentLinters
        end
      end
    end
  end
end
