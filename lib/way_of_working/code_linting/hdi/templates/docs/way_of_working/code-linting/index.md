---
has_children: true
layout: page
---

# Code Linting

## Overview

We use [MegaLinter](https://megalinter.io/) for multi-language linting, with [RuboCop](https://rubocop.org) separately for Ruby to support Minitest and Rails cops.

Linters help by:
- Catching syntax errors, undefined variables, and unused code early
- Ensuring consistent code style across team and projects
- Providing automated quality improvements and best practices
- Saving time in code review and debugging

## Setup

Add linting to your project:

```bash
way_of_working init code_linting
```

This copies organizational coding standards to `.github/linters/` and adds GitHub Actions workflows that run automatically on commits.

{: .note }
For Xcode projects, a SwiftLint build phase is automatically added to the project config.

## Usage

Run linting locally:

```bash
way_of_working exec code_linting
```

This executes both MegaLinter and RuboCop against your code.

## Configuration

Language-specific configs are in `.github/linters/` (e.g., `.rubocop.yml`, `.eslintrc.json`, `.swiftlint.yml`). See [linters.md](linters.md) for the full list.

To customize for your project, modify the config files as needed, but keep changes minimal and well-documented. Changes to linting configs require review by the code-standards-team.

## Handling Exceptions

When linters flag false positives, use inline disable comments with justification:

```python
# pylint: disable=line-too-long - URL cannot be broken
LONG_URL = "https://example.com/very/long/path/..."
```

## Documentation

Generate project documentation:

```bash
way_of_working exec document
```

{: .important }
If you disagree with any linter or coding style, please fork the repository and create a pull request with your proposed changes. The current standards are a starting point intended to evolve with team consensus.

## Resources

- [MegaLinter documentation](https://megalinter.io/)
- [RuboCop documentation](https://rubocop.org)
- [Active linters list](linters.md)
