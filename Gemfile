source 'http://rubygems.org'

gem "rack"
gem "thin"
gem "faye", "~> 0.6.3"
gem "sinatra"
gem "settingslogic"
gem "dalli"
gem "sinatra-jsonp", :require => "sinatra/jsonp"

group :test do
  gem "rspec"
  gem "rack-test"
end

group :development, :test do
  gem "ruby-debug19", :require => "ruby-debug"
  gem "capistrano"
end
