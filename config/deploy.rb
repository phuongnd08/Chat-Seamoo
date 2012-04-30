require "rvm/capistrano"
require "bundler/capistrano"
set :application, "push_app"
set :repository,  "git@github.com:phuongnd08/Chat-Seamoo.git"
set :rails_env, :production

set :scm, :git
set :branch, :master
set :user, "deploy"
set :use_sudo, false
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/#{application}"
set :target_server, ENV["SERVER"]

if target_server.nil?
  raise "Please set target_server with SERVER=ip_or_target_server (of the target machine)"
end

role :app, target_server
role :db, target_server, :primary => true                          # Your HTTP target_server, Apache/etc
role :web, target_server
set :rvm_ruby_string, '1.9.3@push_app'
set :rvm_type, :system

set :bundle_flags,    "--deployment"
set :bundle_without,  [:development, :test, :deploy]

namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{current_path} && bundle exec thin -C thin/production.yml -R config.ru start"
  end

  task :stop, :roles => [:web, :app] do
    run "cd #{current_path} && bundle exec thin -C thin/production.yml -R config.ru stop"
  end

  task :restart, :roles => [:web, :app] do
    run "cd #{current_path} && bundle exec thin -C thin/production.yml -R config.ru restart"
  end

  # This will make sure that Capistrano doesn't try to run rake db:migrate (this is not a Rails project!)
  task :cold do
    update
    start
  end
end
