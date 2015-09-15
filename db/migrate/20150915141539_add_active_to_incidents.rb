class AddActiveToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :active, :boolean, default: true
  end
end
