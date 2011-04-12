#\ -p 3500
require File.expand_path("../boot.rb", __FILE__)
use Faye::RackAdapter, :mount => '/chat', :timeout => 45
run History::App
