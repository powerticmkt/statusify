class Event < ActiveRecord::Base
  belongs_to :incident
  validates_presence_of :message
  validates_presence_of :status
end
