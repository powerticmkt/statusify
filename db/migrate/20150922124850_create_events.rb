class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :message
      t.string :status
      t.belongs_to :incident, index: true

      t.timestamps null: false
    end
      remove_column :incidents, :message
      remove_column :incidents, :begins
      remove_column :incidents, :ends
      remove_column :incidents, :incident_id
  end
end
