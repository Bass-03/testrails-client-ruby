require "bundler/setup"
require 'webmock/rspec'
require "testrail/client"
require_relative "support/fake_testrails.rb"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.before(:each) do
    stub_request(:any, /test.testrail.com\/index.php\?\/api\/v2/).to_rack(FakeTestRail)
  end
  config.example_status_persistence_file_path = ".rspec_status"
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
