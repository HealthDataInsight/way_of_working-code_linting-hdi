# frozen_string_literal: true

require 'way_of_working/cli'
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
    # # This reopens the "way_of_working audit" sub command
    # class Audit
    #   register(CodeLinting::Hdi::Generators::Audit, 'code_linting', 'code_linting',
    # end
    
    # # This reopens the "way_of_working document" sub command
    # class Document
    #   register(CodeLinting::Hdi::Generators::Document, 'code_linting', 'code_linting',
    # end
    
    # # This reopens the "way_of_working exec" sub command
    # class Exec
    #   register(CodeLinting::Hdi::Generators::Exec, 'code_linting', 'code_linting',
    # end

    # # This reopens the "way_of_working init" sub command
    # class Init
    #   register(CodeLinting::Hdi::Generators::Init, 'code_linting', 'code_linting',
    # end

    # # This reopens the "way_of_working new" sub command
    # class New
    #   register(CodeLinting::Hdi::Generators::New, 'code_linting', 'code_linting [NAME]',
    # end
  end
end
