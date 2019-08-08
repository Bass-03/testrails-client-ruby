# Testrail::Client

Based on [testrail_client](https://github.com/zachpendleton/testrail) and [testrail-ruby](https://gitlab.com/RubyAPITools/testrail-ruby) gems.

Why? [testrail_client](https://github.com/zachpendleton/testrail) requires more setup and [testrail-ruby](https://gitlab.com/RubyAPITools/testrail-ruby) has a lot of missing endpoints which hard to maintain and time consuming to add.

This gem provides both the Testrail::Client to send get and posts requests and an idiomatic interface for testrail v2 API, which ever sits better on you.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'testrail-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install testrail-client

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/testrail-client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
