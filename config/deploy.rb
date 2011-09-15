require "bundler/capistrano"
set :application, "chat_app"
set :repository,  "git@github.com:phuongnd08/Chat-Seamoo.git"
set :rails_env, :production

set :scm, :git
set :branch, :master
set :user, "ubuntu"
set :use_sudo, false
ssh_options[:keys] = ["#{Dir.pwd}/dautri.pem"]
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/#{application}"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :app, "46.137.230.20"                          # Your HTTP server, Apache/etc
role :db, "46.137.230.20", :primary => true                          # Your HTTP server, Apache/etc
role :web, "46.137.230.20"                          # Your HTTP server, Apache/etc

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{current_path} && nohup bundle exec thin -C thin/production.yml -R config.ru start"
  end

  task :stop, :roles => [:web, :app] do
    run "cd #{current_path} && nohup bundle exec thin -C thin/production.yml -R config.ru stop"
  end

  task :restart, :roles => [:web, :app] do
    stop
    start
  end

  # This will make sure that Capistrano doesn't try to run rake:migrate (this is not a Rails project!)
  task :cold do
    update
    start
  end
end
