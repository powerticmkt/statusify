class ApplicationMailer < ActionMailer::Base
  default from: APP_CONFIG['mail_from']
  layout 'mailer'
end
