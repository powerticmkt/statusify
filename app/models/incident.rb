class Incident < ActiveRecord::Base
  # The 'incident' model.
  # Incidents are created by Users (belongs_to :user)
  # Incidents may be public or private.
  # Incidents have many events (identified, fixing, etc.)

  belongs_to :user
  has_many :events, dependent: :destroy
  validates :name, presence: true, length: {maximum: 256}
  validates_presence_of :component
  validates_presence_of :user_id
  validates_presence_of :severity
  attr_accessor :status
  # We have to hook AR to make our Incidents/Events thing work. Tricky.
  accepts_nested_attributes_for :events

  def events_as_json
    # Get all events associated with the incident
    # json = true returns JSON
    Event.where(incident_id: self.id).as_json
  end

  def status
    # Getter for status. Returns the status of the last event associated with the incident
    Event.where(incident_id: self.id).last.status
  end

  def status=(status)
    # Setter, raises exception.
    raise "Can't set incident status directly. Use an event to do that."
  end


  def convert_to_level
    # Converts incident severity to bootstrap color, for use with text-<level>
    # Like text-danger, text-warning
    case self.severity
      when 'major'
        'danger'
      when 'minor'
        'warning'
    end
  end

end
