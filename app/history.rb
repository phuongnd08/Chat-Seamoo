require 'sinatra'
require 'sinatra/jsonp'
module History
  class App < Sinatra::Base
    helpers Sinatra::Jsonp
    get '/history' do
      jsonp MessagesLogger.last(params[:channel], (params[:count] || Settings::History.capacity).to_i)
    end
  end

  class Extension
    def incoming(message, callback)
      unless message["channel"] =~ /\/meta\//
        MessagesLogger.add(message["channel"], message["data"])
      end
      callback.call(message)
    end
  end
end
