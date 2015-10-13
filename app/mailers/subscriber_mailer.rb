class SubscriberMailer < ApplicationMailer
  include IncidentsHelper
  @@app_name = APP_CONFIG['name']

  def activate_subscriber(subscriber)
    @activation_url = root_url + "subscribers/activate/#{subscriber.activation_key}"
    mail to: subscriber.email, subject: "Please confirm your subscription for #{@@app_name}'s incidents."
  end

  def notify_subscriber(subscriber, incident_id)
    @incident = Incident.find_by_id(incident_id)
    mail to: subscriber.email, subject: "There is an update to #{@@app_name}'s status.'"
    logger.warn('Sent it')
  end
end
