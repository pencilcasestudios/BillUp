# Deployment reference documentation:
# https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning
# http://beginrescueend.com/integration/capistrano/
# http://thoughtsincomputation.com/posts/deploying-in-harmony-capistrano-rvm-bundler-and-git
# http://stackoverflow.com/questions/6472785/bundler-error-on-deployment




# Basic steps to setup
# ON THE SERVER

# Create the repository:
# $ mkdir /var/Repositories/Git/#{application_name}.git
# $ cd /var/Repositories/Git/#{application_name}.git
# $ git init --bare

# Create the remotes in the development repository
# $ git remote add deployment #{user}@#{server_name}:/var/Repositories/Git/#{application_name}.git

# Push to the repository on the server
# $ git push deployment master
# $ git push deployment deployment




# ON THE DEVELOPMENT MACHINE
# git push deployment deployment
# $ cap deploy:setup
# $ cap deploy:check
# $ cap deploy:update - May require verifying the host key.
# $ cap deploy:migrate
# $ cap deploy:start



# Application-specific settings
set :application_name, AppConfig.application_name
set :gemset_name, AppConfig.gemset_name
set :ruby_version, AppConfig.ruby_version
set :server_name, AppConfig.server_name
set :user, AppConfig.user

set :rvm_ruby_gemset, "#{ruby_version}@#{gemset_name}"




set :bundle_without, [:darwin, :development, :test]

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))              # Add RVM's lib directory to the load path.
require "rvm/capistrano"                                            # Load RVM's capistrano plugin.
# Don't forget to create gemset on the server
set :rvm_ruby_string, "#{rvm_ruby_gemset}"                          # Select the gemset
set :rvm_type, :user                                                # RVM install is in the deploying user's home directory




depend :remote, :gem, "bundler", ">=1.0.21"
depend :remote, :gem, "rake", ">=0.9.2.2"





set :application, "billup.net"
role :app, application
role :web, application
role :db,  application, :primary => true




set :deploy_to, "/var/Apps/#{application_name}"
set :deploy_via, :remote_cache
set :copy_cache, true
set :use_sudo, false




set :scm, :git
# Don't forget to make this repo on the server
set :repository, "#{user}@#{server_name}:/var/Repositories/Git/#{application_name}.git"
# Don't forget to make this branch in the repository
set :branch, "deployment"




namespace :deploy do
  task :start do ; end

  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,"tmp","restart.txt")}"
  end

  desc "Setup shared directory."
  task :setup_shared do
    run "mkdir #{shared_path}/config"
    put File.read("config/examples/database.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/examples/config.yml"), "#{shared_path}/config/config.yml"
    puts "Now edit the config files in #{shared_path}."
  end

  desc "Symlink extra configs and folders."
  task :symlink_extras do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  end
end




after "deploy", "deploy:cleanup" # keeps only last 5 releases
after "deploy:setup", "deploy:setup_shared"
after "deploy:finalize_update", "deploy:symlink_extras"
