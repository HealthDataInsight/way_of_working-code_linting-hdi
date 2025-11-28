# frozen_string_literal: true

# This file provides simplified versions of the classes used by the GitHub audit rule registry
# It deliberately avoids the Zeitwerk naming convention to ensure it isn't autoloaded.
module WayOfWorking
  module Audit
    module Github
      module Rules
        # This is a simplified version of the base class for GitHub audit rules
        class Base
          attr_accessor :errors, :name, :rulesets, :warnings
          attr_reader :fix

          class << self
            # Stores and return the source root for this class
            def source_root(path = nil)
              @source_root = path if path
              @source_root ||= nil
            end
          end

          def initialize(client, name, repo, rulesets, fix = false)
            @client = client
            @name = name
            @repo = repo
            @repo_name = repo.full_name
            @rulesets = rulesets
            @fix = fix
            @errors = []
            @warnings = []
          end

          def status
            @status ||= begin
              result = validate

              if result == :not_applicable
                result
              else
                @errors.empty? ? :passed : :failed
              end
            end
          end

          def self.tags
            [:way_of_working]
          end

          def tags
            self.class.tags
          end
        end

        # This provides the GitHub audit rule factory
        module Registry
          class << self
            attr_accessor :rules

            def register(klass, rule_name)
              @rules ||= {}

              @rules[rule_name] = klass
            end

            def unregister(*rule_names)
              rule_names.each do |rule_name|
                @rules.delete(rule_name)
              end
            end

            def rule(rule_name, *args)
              klass = Registry.rules.fetch(rule_name, Unknown)

              klass.new(*args)
            end
          end
        end

        # This is a stub handler for rules that aren't in the registry.
        class Unknown < Base
          def initialize(*)
            super
            raise 'Error: Unknown client'
          end
        end
      end
    end
  end
end
