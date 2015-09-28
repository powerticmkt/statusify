class AddSeverityToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :severity, :string, default: 'major'
  end
end
