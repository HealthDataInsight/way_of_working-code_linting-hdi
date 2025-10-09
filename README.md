# WayOfWorking::CodeLinting::Hdi

<!-- Way of Working: Main Badge Holder Start -->
![Way of Working Badge](https://img.shields.io/badge/Way_of_Working-v2.0.1-%238169e3?labelColor=black)
<!-- Way of Working: Additional Badge Holder Start -->
<!-- Way of Working: Badge Holder End -->

We use [MegaLinter](https://megalinter.io/) for the majority of our code lining, currently with separate Ruby testing with RuboCop.

Code linters like MegaLinter benefit developers and teams because they help improve code quality, reduce errors and inconsistencies, and streamline development. Linters analyze source code for common issues, such as syntax errors, undefined variables, and unused code, and provide suggestions and feedback for improvement.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add way_of_working-code_linting-hdi
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install way_of_working-code_linting-hdi
```

## Usage

To add [MegaLinter](https://megalinter.io/) to your project, run the following at the command line:

```bash
way_of_working init code_linting
```

to run MegaLinter in your project, run:

```bash
way_of_working exec code_linting
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/HealthDataInsight/way_of_working-code_linting-hdi>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the way_of_working-code_linting-hdi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/HealthDataInsight/way_of_working-code_linting-hdi/blob/main/CODE_OF_CONDUCT.md).
