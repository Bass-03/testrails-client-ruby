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

`$ bundle`

Or install it yourself as:

`$ gem install testrail-client`

## Usage

### Common Configuration

``` ruby
require 'testrail/api'

client = TestRail::Client::Api.new('https://YourTestrailURL')
client.user = 'YourUserName'
client.password = 'YourPassword'
```
### First way, Client::Request
This is how you would normally use the gem [testrail_client](https://github.com/zachpendleton/testrail), it uses Net::HTTP to send requests to the API

``` ruby
# GET case with ID 1
client.send_get("get_case/1")
# GET cases from Project_id 22, limit to 1 case
client.send_get("get_cases/22&limit1")
# POST update to case with ID 1, update case title
client.send_post("update_case/1",{:title => "new Name"})
# POST delete to case with ID 1, delete the case
client.send_post("delete_case/1")
```
### Second way, Client::Api
This is how you would normally use [testrail-ruby](https://gitlab.com/RubyAPITools/testrail-ruby), the change is on how it is coded, but the functionality stays, plus all endpoints from the testrail API are supported

``` ruby
# GET case with ID 1
client.get_case(1)
# GET cases from Project_id 22, limit to 1 case
client.get_cases(22,{:limit => 1})
# POST update to case with ID 1, update case title
client.update_case(1,{:title => "new Name"})
# POST delete to case with ID 1, delete the case
client.delete_case(1)
```
As you see, this is more standardized and easy. It follows the testrail documentation.

## Attachments, the special case.
The add_attachment endpoints require the `multipart/form-data` content type and you to send a File, this is how that is done.

```ruby
# takes result ID and a hash with the file
file = File.open('path/to/file')
client.add_attachment_to_result(1,{:attachment => file})
# takes case ID and a hash with the file
client.add_attachment_to_result_for_case(22,{:attachment => file})
```
## TODO

1.  Test if add_attachment routes actually work

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [mundo03/testrails-client-ruby](https://github.com/mundo03/testrails-client-ruby).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
