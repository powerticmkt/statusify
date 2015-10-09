class SubscriberMailer < ApplicationMailer
  def activate_user(activation_key)
    @activation_key = activation_key
    @activation_url = root_url + /activate/#{activation_key}"
  end
end
