# Loads global application config from config/config.yml
APP_CONFIG = YAML.load_file("#{Rails.root.join('config/config.yml')}")[Rails.env]