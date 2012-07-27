# -*- encoding: utf-8 -*-
require File.expand_path('../lib/green_onion/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ted O'Meara"]
  gem.email         = ["ted@intridea.com"]
  gem.description   = %q{UI testing/screenshot diffing tool}
  gem.summary       = %q{Regressions in the view making you cry? Have more confidence with GreenOnion.}
  gem.homepage      = ""

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "fileutils"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "debugger"
  gem.add_development_dependency "sinatra"
  
  gem.add_dependency "capybara"
  gem.add_dependency "oily_png"
  gem.add_dependency "rainbow"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "green_onion"
  gem.require_paths = ["lib"]
  gem.version       = GreenOnion::VERSION
end
