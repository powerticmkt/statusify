module Statusify
  module Config
    include YAML
    # This houses the application configuration. Set all defaults here, don't use ERb in YAML files.
    # The configuration we got from the config/config.yml file
    YAML_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]

    def app_name
      # The application's name
      # Attempts to read from both - the config file and the environment
      (YAML_CONFIG['name'] || ENV['APP_NAME']).capitalize
    end

    def theme
      # The current theme we're using
      YAML_CONFIG['theme'] || 'flat-ui'
    end
  end
end
