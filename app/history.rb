require 'sinatra'
module History
  class App < Sinatra::Base
    get '/' do
      content_type :json
      MessagesLogger.last((params[:count] || Settings::History.capacity).to_i).to_json
    end
  end

  class Extension
    def incoming(message, callback)
      MessagesLogger.add(message)
      callback.call(message)
    end
  end
end
