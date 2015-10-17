class Event < ActiveRecord::Base
  belongs_to :incident
  validates_presence_of :message
  validates_presence_of :status
  validate :maintain_event_uniqueness

  def maintain_event_uniqueness
    matching_event = Event.find_by(message: message, incident_id: incident_id)
    if matching_event
      self.created_at = matching_event.created_at
      matching_event.delete
    end
    true
  end

  def as_json(options = {})
    options[:except] = [:id, :incident_id]
    super(options)
  end
end
