require 'settingslogic'
module Settings
  class History < Settingslogic
    source File.join(settings.root, "config", "history.yml")
  end
end
