require 'sinatra'
module History
  class App < Sinatra::Base
    get '/' do
      debugger
      content_type :json
      [{:a => "x"}].to_json
    end
  end
end
