<!-- markdownlint-disable-file MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2026-11-16

### Added

- JavaScript projects get `npm run lint` and `npm run lint:fix` scripts in `package.json` (#14)

### Changed

- Replaced the `.eslintrc.js` and `.eslintignore` templates with an ESLint flat config (`eslint.config.js`) using neostandard, as MegaLinter's bundled ESLint no longer reads legacy config; MegaLinter now runs the project's own eslint
- Removed linters that MegaLinter no longer ships from the `.mega-linter.yml` template; their replacements (e.g. `REPOSITORY_SECRETLINT`, `REPOSITORY_CHECKOV`, `REPOSITORY_GIT_DIFF`, `SPELL_LYCHEE`) were already enabled

### Removed

- The `.github/linters/.markdown-link-check.json` template, as MegaLinter no longer ships markdown-link-check; the generator now deletes it from existing projects

### Fixed

- MegaLinter no longer runs out of runner disk space: the HDI custom flavor action now frees space before pulling its image (HealthDataInsight/megalinter-custom-flavor-hdi#2)

## [1.1.2] - 2026-06-08

### Changed

- Bumped the `way_of_working` dependency to `~> 2.1`

## [1.1.1] - 2025-11-28

### Changed

- Updated GitHub rule signatures
- Removed Zeitwerk ignore to make it happier

## [1.1.0] - 2025-10-15

### Added

- Switched from Standard to ESLint (with Standard rules) to enable us to add Cypress and Jasmine globals
- Added CODEOWNERS protection of the linting standards files

### Changed

- Switched to MegaLinter v9
- Updated the linting GitHub workflow in line with upstream changes
- Rewritten the documentation to be easier to read for both humans and LLMs.

## [1.0.0] - 2025-01-27

### Added

- Added a document command to update the list of used and available linters
- Added Swiftlint build phase to Xcode projects
- Added MegaLinter for linting common file formats with generator command and rake task
- Added a GitHub audit rule to check that linting is used and configured correctly

[unreleased]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/compare/v1.1.2...v1.2.0
[1.1.2]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/compare/v1.1.1...v1.1.2
[1.1.1]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/compare/v1.0.0...v1.1.1
[1.1.0]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/releases/tag/v1.0.0
