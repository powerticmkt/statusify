class SubscriberMailer < ApplicationMailer
  def activate_user(user)
    @activation_key = user.activation_key
    @activation_url = root_url + "/subscribers/activate/#{@activation_key}"
    mail to: user.email, subject: "Please confirm your subscription for #{APP_CONFIG['name']}'s incidents."
  end
end
