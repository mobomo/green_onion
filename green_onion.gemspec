# -*- encoding: utf-8 -*-
require File.expand_path('../lib/green_onion/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ted O'Meara"]
  gem.email         = ["ted@intridea.com"]
  gem.description   = %q{UI testing/screenshot diffing tool}
  gem.summary       = %q{Regressions in the view making you cry? Have more confidence with GreenOnion.}
  gem.homepage      = "http://intridea.github.com/green_onion"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "sinatra"
  
  gem.add_dependency "capybara", "1.1.2"
  gem.add_dependency "capybara-webkit", "0.12.1"
  gem.add_dependency "oily_png", "1.0.2"
  gem.add_dependency "rainbow", "1.1.4"
  gem.add_dependency "fileutils", "0.7"
  gem.add_dependency "thor", "0.15.4"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "green_onion"
  gem.require_paths = ["lib"]
  gem.version       = GreenOnion::VERSION
end
