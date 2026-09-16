require 'test_helper'

module WayOfWorking
  module CodeLinting
    module Hdi
      module Generators
        # This class tests the Linter::Init Thor Group (generator)
        class DocumentLintersTest < Rails::Generators::TestCase
          tests WayOfWorking::CodeLinting::Hdi::Generators::Init
          destination WayOfWorking::CodeLinting::Hdi.root.join('tmp/generators')
          setup :prepare_destination

          test 'generator runs without errors' do
            assert_nothing_raised do
              run_generator
            end
          end

          test 'files are created and revoked' do
            run_generator

            assert_file 'docs/way_of_working/code-linting/index.md'
            assert_file 'docs/way_of_working/code-linting/linters.md'

            run_generator [], behavior: :revoke

            assert_no_file 'docs/way_of_working/code-linting/index.md'
            assert_no_file 'docs/way_of_working/code-linting/linters.md'
          end

          # Regression: a heading-only h2 (e.g. "Comments") with no linter table
          # must not raise or produce empty sections. See issue #23.
          test 'sections with no linter rows are skipped' do
            gen = WayOfWorking::CodeLinting::Hdi::Generators::DocumentLinters.new
            gen.stubs(:enabled_linters).returns([])
            gen.stubs(:parse_linter_types_html)
               .yields('Languages', [linter_row])
               .then.yields('Comments', [])

            assert_nothing_raised { gen.prepare_linter_lists }

            types = gen.instance_variable_get(:@types)
            assert_equal ['Languages'], types.keys
          end

          private

          def linter_row
            Nokogiri::HTML(<<~HTML).css('tbody tr').first
              <table><tbody><tr>
                <td></td>
                <td>Ruby</td>
                <td><a href="../descriptors/ruby_rubocop">RuboCop</a><a>RUBY_RUBOCOP</a></td>
              </tr></tbody></table>
            HTML
          end
        end
      end
    end
  end
end
