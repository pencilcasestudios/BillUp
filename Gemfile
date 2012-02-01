source "http://rubygems.org"




# Our foundation
gem "rails", "3.1.3"




# Used accross environments
gem "bcrypt-ruby", "~> 3.0.0"
gem "daemons"
gem "delayed_job_active_record", "~> 0.2.1"
gem "exception_notification"
gem "galetahub-simple_captcha", require: "simple_captcha"
gem "jquery-rails"
gem "nested_form", git: "git://github.com/ryanb/nested_form.git"
gem "paper_trail", "~> 2"
gem "prawn_rails"
gem "settingslogic"


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "coffee-rails", "~> 3.1.0"
  gem "jombo", "~> 1.0.1"
  gem "pcs_tablesorter", "~> 0.0.1.beta"
  gem "sass-rails", "~> 3.1.0"
  gem "uglifier"
end




group :test, :development do
  gem "rspec-rails" #, :git => "git://github.com/rspec/rspec-rails.git"
  gem "sqlite3"
end

group :test, :darwin do
  gem "rb-fsevent"
  #gem "rb-readline"
end

group :test do
  gem "capybara"
  gem "factory_girl_rails"
  gem "guard", git: "git://github.com/guard/guard.git"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "guard-spork" #, git: "git://github.com/guard/guard-spork.git"
  gem "launchy" # Ref: http://techiferous.com/2010/04/using-capybara-in-rails-3/ for save_and_open_page to work
  #gem "spork", "> 0.9.0.rc"
end




group :development do
  gem "capistrano"
  gem "letter_opener"
end




group :production do
  #gem "unicorn"
  gem "mysql2"
end
