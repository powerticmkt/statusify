class SubscriberMailer < ApplicationMailer
  include IncidentsHelper

  def activate_subscriber(subscriber)
    @activation_url = root_url + "subscribers/activate/#{subscriber.activation_key}"
    mail to: subscriber.email, subject: "Please confirm your subscription for #{Statusify.app_name}'s incidents."
  end

  def notify_subscriber(subscriber, incident_id, new = false)
    # The 'new' parameter is true when we have a new incident
    @incident = Incident.find_by_id(incident_id)
    @activation_key = subscriber.activation_key
    @new = new
    # Change the subject if we have a new incident
    subject = @new ? "#{Statusify.app_name} has a new incident." : "There is an update to #{Statusify.app_name}'s status."
    mail to: subscriber.email, subject: subject
  end
end
