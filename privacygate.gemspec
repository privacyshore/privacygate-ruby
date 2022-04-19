<<<<<<< HEAD:privacygate.gemspec
# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require 'privacygate/version'

Gem::Specification.new do |gem|
  gem.name          = "privacygate"
  gem.version       = "1.0.0"
  gem.license       = "MIT"
  gem.required_ruby_version = ">= 2.0.0"
  gem.authors       = ["PrivacyGate"]

  gem.description   = "Client library for PrivacyGate API"
  gem.summary       = "Client library for PrivacyGate API"
  gem.homepage      = "https://privacygate.io/docs/"

  gem.files         = `git ls-files`.sub("privacygate.gemspec", "privacygate.gemspec").split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("faraday", "~> 0.10")

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmock"
  gem.add_development_dependency "pry-byebug"
end
=======
# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require 'coinbase_commerce/version'

Gem::Specification.new do |gem|
  gem.name          = "privacygate"
  gem.version       = "1.0.0"
  gem.license       = "MIT"
  gem.required_ruby_version = ">= 2.0.0"
  gem.authors       = ["Coinbase Commerce", "PrivacyGate"]

  gem.description   = "Client library for PrivacyGate API"
  gem.summary       = "Client library for PrivacyGate API"
  gem.homepage      = "https://privacygate.io/docs/"

  gem.files         = `git ls-files`.sub("coinbase_commerce.gemspec", "privacygate.gemspec").split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("faraday", "~> 0.10")

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmock"
  gem.add_development_dependency "pry-byebug"
end
>>>>>>> f6dbc7fc0d5b6d5193711f2f10bc913b14c312f8:coinbase_commerce.gemspec
