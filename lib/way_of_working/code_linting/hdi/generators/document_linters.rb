# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/string'
require 'nokogiri'
require 'open-uri'
require 'thor'
require 'way_of_working/paths'

module WayOfWorking
  module CodeLinting
    module Hdi
      module Generators
        # This class is responsible for generating linter documentation
        class DocumentLinters < Thor::Group
          include Thor::Actions # Mixin for action methods provided by Thor
          include GithubMetadata

          # Set the source root for the templates
          source_root ::WayOfWorking::CodeLinting::Hdi.source_root

          # URL of the supported linters
          SUPPORTED_LINTERS_URL = 'https://megalinter.io/latest/supported-linters/'

          # Method to prepare the list of linters from the supported linters URL
          def prepare_linter_lists
            # Initialize an empty hash for linter types
            @types = {}

            # Iterate over each linter type in the parsed HTML
            parse_linter_types_html do |type, html_rows|
              @types[type] = []

              parse_linter_rows(html_rows) do |constant_name, language, name, link|
                # Create a new linter object and add it to the list
                @types[type] << SupportedLinter.new(language, constant_name, name, link,
                                                    enabled_linters)
              end
            end
          end

          # Method to create the linter documentation using a template
          def create_linters_documentation
            template 'docs/way_of_working/code-linting/linters.md'
            template 'docs/way_of_working/code-linting/index.md'
          end

          private

          def parse_linter_types_html
            # Parse HTML from the supported linters URL
            doc = Nokogiri::HTML(URI.parse(SUPPORTED_LINTERS_URL).read)

            doc.css('article h2').each do |h2|
              type = h2.text.strip

              yield type, h2.next_element.css('tbody tr')
            end
          end

          def parse_linter_rows(html_rows)
            # Iterate over each linter in the current type
            html_rows.each do |tr|
              tds = tr.css('td')
              constant_name = tds[2].css('a')[1].text
              language = tds[1].text.sub(/\s\([^)]+\)\z/, '')
              name = tds[2].css('a')[0].text
              link = tds[2].css('a')[0].attributes['href'].value.sub(/\A\.\./, 'https://megalinter.io/latest')

              yield constant_name, language, name, link
            end
          end

          # Load enabled linters from the YAML config file
          def enabled_linters
            config_file = File.join(destination_root, '.mega-linter.yml')
            @enabled_linters ||= File.exist?(config_file) ? YAML.safe_load_file(config_file)['ENABLE_LINTERS'] : []
          end
        end
      end
    end
  end
end
