
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "testrail/client/version"

Gem::Specification.new do |spec|
  spec.name          = "testrail-client"
  spec.version       = Testrail::Client::VERSION
  spec.authors       = ["Edmundo Sanchez"]
  spec.email         = ["zomundo@gmail.com"]

  spec.summary       = "Another Client wrapper in Ruby for TestRail API (v2)"
  spec.description   = "An easy to mantain gem that wrapps the v2 testrail API"
  spec.homepage      = "https://github.com/mundo03/testrails-client-ruby"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.6.3'
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sinatra"
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'config_this'

end
