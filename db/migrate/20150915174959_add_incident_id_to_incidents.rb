class AddIncidentIdToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :incident_id, :integer
  end
end
