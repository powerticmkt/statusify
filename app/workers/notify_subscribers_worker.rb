class NotifySubscriberWorker
  include Sidekiq::Worker

  def perform(incident_id, new=false)
    # Notify all activated subscribers when there's an update to an incident
    # Set new to true if there's a new incident
    @new = new
    Subscriber.where(activated: true).find_each do |subscriber|
      # Schedule the mail
      SubscriberMailer.delay.notify_subscriber(subscriber, incident_id, @new)
    end
  end
end