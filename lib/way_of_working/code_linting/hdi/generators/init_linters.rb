# frozen_string_literal: true

require 'thor'
require 'way_of_working/paths'

module WayOfWorking
  module CodeLinting
    module Hdi
      module Generators
        # This generator initialises the linter
        class InitLinters < Thor::Group
          include Thor::Actions
          include GithubMetadata

          source_root ::WayOfWorking::CodeLinting::Hdi.source_root

          LINTING_BUILD_PHASE =
            "				2F0882F42AAB152D00DB0B2B /* ShellScript */,\n"
          LINTING_BUILD_PHASE_DETAILS = <<~CONFIG
            /* Begin PBXShellScriptBuildPhase section */
            \t\t2F0882F42AAB152D00DB0B2B /* ShellScript */ = {
            \t\t\tisa = PBXShellScriptBuildPhase;
            \t\t\tbuildActionMask = 2147483647;
            \t\t\tfiles = (
            \t\t\t);
            \t\t\tinputFileListPaths = (
            \t\t\t);
            \t\t\tinputPaths = (
            \t\t\t);
            \t\t\toutputFileListPaths = (
            \t\t\t);
            \t\t\toutputPaths = (
            \t\t\t);
            \t\t\trunOnlyForDeploymentPostprocessing = 0;
            \t\t\tshellPath = /bin/sh;
            \t\t\tshellScript = "if [[ \\"$(uname -m)\\" == arm64 ]]; then\\n    export PATH=\\"/opt/homebrew/bin:$PATH\\"\\nfi\\n\\nif which swiftlint > /dev/null; then\\n  swiftlint\\nelse\\n  echo \\"warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint\\"\\nfi\\n";
            \t\t};
            /* End PBXShellScriptBuildPhase section */

          CONFIG

          def project_github_linters_directory
            protect_files_in_codeowners '/.github/linters/'
          end

          def copy_github_linters_rubocop_config_file
            copy_file '.github/linters/rubocop_defaults.yml'
          end

          def copy_github_linters_markdown_link_check_config_file
            copy_file '.github/linters/.markdown-link-check.json'
          end

          def configure_markdownlint
            # We don't have these files in the repo, but we want to protect them in CODEOWNERS
            protect_files_in_codeowners '.markdownlintignore', '.markdownlint.*'

            prepend_to_file_if_exists 'CHANGELOG.md', "<!-- markdownlint-disable-file MD024 -->\n"
          end

          def configure_eslint
            if javascript_files_present?
              protect_and_copy_file '.eslintrc.js'

              # We don't have an eslintignore file in the repo, but we want to protect it in CODEOWNERS
              protect_files_in_codeowners '.eslintignore'

              run 'npm install --save-dev ' \
                  'eslint-config-standard@^17.1.0 ' \
                  'eslint-plugin-cypress@^3.6.0 ' \
                  'eslint-plugin-jasmine@^4.2.2'
            else
              say 'No JavaScript files found, skipping ESLint configuration'
            end
          end

          def copy_megalinter_github_workflow_action
            protect_and_copy_file '.github/workflows/mega-linter.yml'
          end

          def copy_megalinter_dot_file
            protect_and_copy_file '.mega-linter.yml'
          end

          def create_gitignore_if_missing
            create_file_if_missing '.gitignore'
          end

          def gitignore_reports_folder
            append_to_file '.gitignore', "megalinter-reports/\n"
          end

          def gitignore_rubocop_cached_file
            append_to_file '.gitignore', ".rubocop-https---*\n"
          end

          def copy_rubocop_options_file
            protect_and_copy_file '.rubocop'
          end

          def inject_swiftlint_into_xcode_project_build_process
            return unless xcode_project_file && File.exist?(xcode_project_file)

            inject_into_file xcode_project_file,
                             LINTING_BUILD_PHASE,
                             after: "buildPhases = (\n"

            inject_into_file xcode_project_file,
                             LINTING_BUILD_PHASE_DETAILS,
                             after: "/* End PBXResourcesBuildPhase section */\n\n"
          end

          private

          def prepend_to_file_if_exists(file, content)
            file_path = File.join(destination_root, file)

            prepend_to_file file, content if File.exist?(file_path)
          end

          def protect_and_copy_file(file)
            protect_files_in_codeowners(file)
            copy_file(file)
          end

          def javascript_files_present?
            Dir.glob(File.join(destination_root, '**/*.{js,jsx,mjs,cjs}')).
              reject { |file| file.end_with?('.eslintrc.js') }.
              reject { |file| file.include?('/megalinter-reports/') }.
              any?
          end

          def xcode_project_file
            Dir.glob(File.join(destination_root, '*.xcodeproj/project.pbxproj')).first
          end

          def create_file_if_missing(path)
            path = File.join(destination_root, path)
            return if behavior == :revoke || File.exist?(path)

            File.open(path, 'w', &:write)
          end

          def codeowners_file_path
            ['.github/CODEOWNERS', 'CODEOWNERS', 'docs/CODEOWNERS'].each do |path|
              full_path = File.join(destination_root, path)
              return full_path if File.exist?(full_path)
            end
            File.join(destination_root, '.github/CODEOWNERS')
          end

          def protect_files_in_codeowners(*files)
            return unless github_organisation

            codeowners_path = codeowners_file_path
            create_file(codeowners_path) unless File.exist?(codeowners_path)

            owner = "@#{github_organisation}/#{code_standards_team}"

            files.each do |file|
              append_to_file codeowners_path, "#{file} #{owner}\n"
            end
          end
        end
      end
    end
  end
end
