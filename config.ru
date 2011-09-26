#\ -p 3500
require File.expand_path("../boot.rb", __FILE__)
use Faye::RackAdapter, :mount => '/pubsub', :timeout => 25
Faye::Logging.log_level = :info
Faye.logger = lambda { |m| puts m }
run History::App
