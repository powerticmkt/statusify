class ApplicationMailer < ActionMailer::Base
  # We need to reload our configuration since Sidekiq doesn't play nice with it
  require_relative('../../lib/statusify/statusify')
  include Statusify
  # Require our helpers
  Dir[File.join(File.dirname(__FILE__), '..', 'helpers', '*.rb')].each {|file| require file }
  default from: Statusify.app_name
  layout 'mailer'
end
