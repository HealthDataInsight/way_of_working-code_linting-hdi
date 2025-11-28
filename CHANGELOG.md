<!-- markdownlint-disable-file MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[unreleased]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/compare/v1.1.1...HEAD
[1.1.1]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/compare/v1.0.0...v1.1.1
[1.1.0]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/releases/tag/v1.0.0
