class NotifySubscriberWorker
  include Sidekiq::Worker

  def perform(incident_id)
    # Notify all activated subscribers when there's an update to an incident
    Subscriber.where(activated: true).find_each do |subscriber|
      # Schedule the mail
      SubscriberMailer.delay.notify_subscriber(subscriber, incident_id)
    end
  end
end