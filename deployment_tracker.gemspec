# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deployment_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = 'deployment_tracker'
  spec.version       = DeploymentTracker::VERSION
  spec.authors       = ['Stuart Ingram']
  spec.description   = 'Rails 3 API & Capistrano support for deployment tracking'
  spec.summary       = 'Rails 3 API & Capistrano support for deployment tracking'
  spec.homepage      = 'https://github.com/singram/deployment_tracker'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency  'rails', '>=3.2'
  spec.add_dependency  'capistrano', '<3.0.0'
  spec.add_development_dependency 'bundler', '~>1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'capistrano-spec'
end
