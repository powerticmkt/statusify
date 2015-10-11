class ApplicationMailer < ActionMailer::Base
  # We need to reload APP_CONFIG since Sidekiq doesn't play nice with it
  APP_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/config.yml")).result)[Rails.env]
  default from: APP_CONFIG['name']
  layout 'mailer'
end
