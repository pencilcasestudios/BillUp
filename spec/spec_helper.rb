require "rubygems"
require "spork"

Spork.prefork do
  ENV["RAILS_ENV"] ||= "test"
  require File.expand_path("../../config/environment", __FILE__)
  require "rspec/rails"
  require "capybara/rspec"

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include(EmailerMacros)  
    config.before(:each) { reset_email }  
    #config.include FactoryGirl::Syntax::Methods # Ref: https://github.com/thoughtbot/factory_girl/wiki/Usage
  end

  Capybara.configure do |config|
    config.run_server = false
    config.app_host   = "http://billup.site"  # Set 127.0.0.1 billup.site in /etc/hosts
  end
end

Spork.each_run do
  FactoryGirl.reload
  I18n.reload!
  load "#{Rails.root}/config/routes.rb"
end
