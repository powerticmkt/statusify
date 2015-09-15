class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :name
      t.string :component
      t.string :status
      t.boolean :public, default: true
      t.string :message
      t.timestamp :begins
      t.timestamp :ends
      t.references :user

      t.timestamps null: false
    end
    add_foreign_key :incidents, :users
  end
end
