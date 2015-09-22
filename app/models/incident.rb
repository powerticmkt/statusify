class Incident < ActiveRecord::Base
  # The 'incident' model.
  # Incidents are created by Users (belongs_to :user)
  # Incidents may be public or private.
  # Incidents have many events (identified, fixing, etc.)

  belongs_to :user
  has_many :events, dependent: :destroy
  validates :name, presence: true, length: { maximum: 256 }
  validates_presence_of :component
  validates_presence_of :public
  validates_presence_of :user_id
  # We have to hook AR to make our Incidents/Events thing work. Tricky.
  accepts_nested_attributes_for :events

  private

  def incident_params
    params.require(:incident).permit(:name, :status, :user_id, :message)
  end
end
