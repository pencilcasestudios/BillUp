source "http://rubygems.org"




# Our foundation
gem "rails", "3.1.3"




# Used accross environments
gem "bcrypt-ruby", "~> 3.0.0"
gem "delayed_job_active_record", "~> 0.2.1"
gem "galetahub-simple_captcha", :require => "simple_captcha"
gem "jquery-rails"
gem "nested_form", git: "git://github.com/ryanb/nested_form.git"
gem "paper_trail", "~> 2"
gem "prawn_rails"
gem "settingslogic"


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "coffee-rails", "~> 3.1.0"
  gem "jombo", "~> 0.0.1.beta7"
  gem "sass-rails", "~> 3.1.0"
  gem "uglifier"
end




group :test do
  gem "capybara"
  gem "factory_girl_rails"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "guard-spork"#, :git => "git://github.com/guard/guard-spork.git"
  gem "launchy" # Ref: http://techiferous.com/2010/04/using-capybara-in-rails-3/ for save_and_open_page to work
  gem "rspec-rails"
  gem "spork", "> 0.9.0.rc"
  gem "sqlite3"
end

group :test, :darwin do
  gem "rb-fsevent"#, "~> 0.9.0.pre4"
  gem "rb-readline"
end




group :development do
  gem "capistrano"
  gem "letter_opener"
  gem "rspec-rails"
  gem "sqlite3"
end




group :production do
  #gem "unicorn"
  gem "exception_notification"
  gem "mysql2"
end
