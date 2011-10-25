# Deployment reference documentation:


# Ref: http://beginrescueend.com/integration/capistrano/
# http://thoughtsincomputation.com/posts/deploying-in-harmony-capistrano-rvm-bundler-and-git
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))              # Add RVM's lib directory to the load path.
require "rvm/capistrano"                                            # Load RVM's capistrano plugin.
# Don't forget to create gemset on the server
set :rvm_ruby_string, "ruby-1.9.2-p290@billup-rails.3.1.x"          # Select the gemset
set :rvm_type, :user                                                # RVM install is in the deploying user's home directory

require "bundler/capistrano"



depend :remote, :gem, "bundler", ">=1.0.21"
depend :remote, :gem, "rake", ">=0.9.2.2"





set :application, "billup.net"
role :app, application
role :web, application
role :db,  application, :primary => true




set :user, "silumesii"
set :deploy_to, "/var/Apps/BillUp"
set :deploy_via, :remote_cache
set :copy_cache, true
set :use_sudo, false




set :scm, :git
# Don't forget to make this repo on the server
set :repository, "silumesii@billup.net:/var/Repositories/Git/BillUp.git"
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
after "deploy:update_code", "deploy:symlink_extras"