ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rubygems'
require 'bundler/setup'
require 'capistrano'
require 'capistrano-spec'
require 'rspec/rails'
require 'rspec/autorun'

Rails.backtrace_cleaner.remove_silencers!
# Load support files

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include Capistrano::Spec::Matchers
  config.include Capistrano::Spec::Helpers
end

require File.expand_path("../../lib/deployment_tracker/recipes.rb", __FILE__)
