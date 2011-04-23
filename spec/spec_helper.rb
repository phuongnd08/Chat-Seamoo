ENV['RACK_ENV'] = "test"
require File.expand_path("../../boot.rb", __FILE__)
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each {|f| require f}
require 'rspec'
require 'rack/test'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
