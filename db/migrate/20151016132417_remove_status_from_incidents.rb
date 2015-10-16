class RemoveStatusFromIncidents < ActiveRecord::Migration
  def change
    remove_column :incidents, :status
  end
end