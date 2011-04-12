ENV["RACK_ENV"] ||= "development"
require 'rubygems'
require 'bundler'
Bundler.require(:default, ENV["RACK_ENV"].to_sym)
["lib", "settings", "app"].each do |dir|
  Dir["./#{dir}/**/*.rb"].each { |f| require f }
end
