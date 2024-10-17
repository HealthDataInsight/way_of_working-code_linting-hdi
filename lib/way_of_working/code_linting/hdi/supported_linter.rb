module WayOfWorking
  module CodeLinting
    module Hdi
      # Struct to hold linter data
      class SupportedLinter
        # Reasons why certain linters are not used
        NOT_USED_REASON = {
          'CSS_SCSS_LINT' => 'scss-lint recommends using stylelint',
          'HTML_DJLINT' => 'Refuses to see config file',
          'RUBY_RUBOCOP' => 'RuboCop is used directly'
        }.freeze

        # Acronyms for languages
        TLA_LANGUAGES = %w[
          CSS
          ENV
          HTML
          JSON
          JSX
          PHP
          SQL
          TSX
          XML
          YAML
        ].freeze

        # Mapping for languages
        LANGUAGE_MAPPINGS = {
          'Action' => 'GitHub Action',
          'Arm' => 'ARM Templates',
          'Cloudformation' => 'CloudFormation',
          'Coffee' => 'CoffeeScript',
          'Editorconfig' => 'EditorConfig',
          'Graphql' => 'GraphQL',
          'Javascript' => 'JavaScript',
          'Latex' => 'LaTeX',
          'Protobuf' => 'Protocol Buffers',
          'Rst' => 'reStructuredText',
          'Spell' => 'Spelling',
          'Typescript' => 'TypeScript',
          'Visual Basic .Net' => 'VB.Net'
        }.freeze

        attr_accessor :name, :link, :enabled_linters, :sorter

        def initialize(language, constant_name, name, link, enabled_linters)
          @original_language = language
          @original_constant_name = constant_name
          @name = name
          @link = link
          @enabled_linters = enabled_linters

          # Array used for sorting
          @sorter = [@original_language, @original_constant_name]
        end

        def language
          language = @original_language

          # Titleize language unless it is an acronym
          language = language.titleize unless TLA_LANGUAGES.include?(language)

          # Use mapped language name if available
          language = LANGUAGE_MAPPINGS[language] if LANGUAGE_MAPPINGS.key?(language)

          language
        end

        def constant_name
          return @original_constant_name if enabled_linters.include?(@original_constant_name)

          # Strike-through the constant name if the linter is not used
          "~~#{@original_constant_name}~~"
        end

        def details
          return "[#{name}](#{link})" if enabled_linters.include?(@original_constant_name)

          details = 'Not Used'

          # Add reason if available
          if NOT_USED_REASON.key?(@original_constant_name)
            details = "#{details} (#{NOT_USED_REASON[@original_constant_name]})"
          end

          details
        end
      end
    end
  end
end
