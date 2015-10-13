class ApplicationMailer < ActionMailer::Base
  # We need to reload APP_CONFIG since Sidekiq doesn't play nice with it
  APP_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/config.yml")).result)[Rails.env]
  # Require our helpers
  Dir[File.join(File.dirname(__FILE__), '..', 'helpers', '*.rb')].each {|file| require file }
  default from: APP_CONFIG['name']
  layout 'mailer'
end
