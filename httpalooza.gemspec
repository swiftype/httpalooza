# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'httpalooza/version'

Gem::Specification.new do |spec|
  spec.name          = "httpalooza"
  spec.version       = HTTPalooza::VERSION
  spec.authors       = ["Quin Hoxie"]
  spec.email         = ["qhoxie@gmail.com"]

  spec.summary       = %q{HTTPalooza brings together the best Ruby HTTP clients on one stage.}
  spec.homepage      = "http://httpalooza.com/"
  spec.license       = "MIT"

  spec.post_install_message = "HTTPalooza! Ruby's greatest HTTP clients, on stage together."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "addressable"
  spec.add_dependency "rack"

  spec.add_development_dependency "curb"
  spec.add_development_dependency "typhoeus"
  spec.add_development_dependency "patron"
  spec.add_development_dependency "httpclient"
  spec.add_development_dependency "rest-client"
  spec.add_development_dependency "unirest"
  spec.add_development_dependency "em-synchrony"
  spec.add_development_dependency "em-http-request"
  spec.add_development_dependency "selenium-webdriver"
  spec.add_development_dependency "chromedriver-helper"

  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4.0"
end
