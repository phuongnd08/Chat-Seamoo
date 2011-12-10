require "bundler/capistrano"
set :application, "push_app"
set :repository,  "git@github.com:phuongnd08/Chat-Seamoo.git"
set :rails_env, :production

set :scm, :git
set :branch, :master
set :user, "root"
set :use_sudo, false
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/#{application}"

role :app, "push.giasudientu.com"                          # Your HTTP server, Apache/etc
role :db, "push.giasudientu.com", :primary => true                          # Your HTTP server, Apache/etc
role :web, "push.giasudientu.com"                          # Your HTTP server, Apache/etc

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "monit start push_server"
  end

  task :stop, :roles => [:web, :app] do
    run "monit stop push_server"
  end

  task :restart, :roles => [:web, :app] do
    run "monit restart push_server"
  end

  # This will make sure that Capistrano doesn't try to run rake db:migrate (this is not a Rails project!)
  task :cold do
    update
    start
  end
end
