class Subscriber < ActiveRecord::Base
  # A subscriber is someone who signs up to keep track of one or more incidents
  # We must send a confirmation mail before we begin to send notifications, because everyone hates spam
  # The activated field does just that
  # We also have the email field, which must adhere to the email regex
  # The activation_key field is a 20-char base64 string to verify if the subscriber has actually subscribed
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, }

  before_save do
    # Generate the activation key and return it
    self.activation_key = SecureRandom.urlsafe_base64(20)
  end

  def self.activate
    # Activate the subscriber
    # Returns true if the key is valid and the subscriber isn't already activated
    # Else, returns nil
    subscriber = Subscriber.find_by_activation_key(self.activation_key)
    if subscriber && !subscriber.activated
      subscriber.activated = true
      true
    else
      nil
    end
  end

end
