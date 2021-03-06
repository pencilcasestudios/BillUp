require "rubygems"
require "spork"
require "rack_session_access/capybara"

Spork.prefork do
  ENV["RAILS_ENV"] ||= "test"
  require File.expand_path("../../config/environment", __FILE__)
  require "capybara/rspec"
  require "rspec/autorun"
  require "rspec/rails"

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include(EmailerMacros)
    config.before(:each) { reset_email }
    config.order = "random"
  end

  Capybara.configure do |config|
    config.run_server = false
    config.app_host   = "http://billup.dev"  # Set 127.0.0.1 billup.dev in /etc/hosts
  end
end

Spork.each_run do
  FactoryGirl.reload
  I18n.reload!
  load "#{Rails.root}/config/routes.rb"
end
