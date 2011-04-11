require 'faye'
chat_server = Faye::RackAdapter.new(:mount => '/chat', :timeout => 45)
run chat_server
