require 'settingslogic'
module Settings
  class Memcached < Settingslogic
    source File.join(settings.root, "config", "memcached.yml")
    namespace ENV["RACK_ENV"]
  end
end
