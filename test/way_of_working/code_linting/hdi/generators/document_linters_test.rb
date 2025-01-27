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
        end
      end
    end
  end
end
