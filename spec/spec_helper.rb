ENV['RACK_ENV'] = "test"
require File.expand_path("../../boot.rb", __FILE__)
require 'rspec'
require 'rack/test'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
