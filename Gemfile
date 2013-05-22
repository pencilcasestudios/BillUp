source "https://rubygems.org"




gem "rails"




# Used accross environments
#gem "rails-backbone"
gem "bcrypt-ruby" # To use ActiveModel has_secure_password
gem "bundler"
gem "cancan"
gem "carrierwave" #, git: "git://github.com/jnicklas/carrierwave.git"
gem "carrierwave_backgrounder"
gem "daemons"
gem "delayed_job_active_record" #, git: "git://github.com/collectiveidea/delayed_job_active_record.git"
gem "exception_notification"
gem "galetahub-simple_captcha", require: "simple_captcha"#, git: "git://github.com/galetahub/simple-captcha.git"
gem "jquery-rails"
gem "mini_magick"
gem "nested_form" #, git: "git://github.com/ryanb/nested_form.git"
gem "paper_trail"
gem "prawn_rails"
gem "rake"
gem "rvm"
gem "settingslogic"
gem "state_machine"




# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "coffee-rails"
  gem "jombo"
  gem "pcs_tablesorter"
  gem "sass-rails"
  gem "uglifier"
end




group :development do
  gem "capistrano"
  gem "capistrano-ext"
  gem "letter_opener"
  gem "rvm-capistrano"
end

group :test do
  gem "capybara"
  gem "factory_girl_rails"
  gem "guard-bundler"
  gem "guard-rspec"
  gem "guard-spork"
  gem "launchy" # Ref: http://techiferous.com/2010/04/using-capybara-in-rails-3/ for save_and_open_page to work
  gem "rack_session_access"
  gem "spork-rails"
end

group :test, :development do
  #gem "rb-fsevent" # Mac
  gem "rb-inotify", "~> 0.9"
  gem "rspec-rails"
  gem "sqlite3"
end




group :production do
  gem "mysql2"
end
