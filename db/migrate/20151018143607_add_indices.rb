class AddIndices < ActiveRecord::Migration
  def change
    # Adds indices wherever we use a where statement
    add_index :incidents, :created_at
    add_index :incidents, :active
    add_index :subscribers, :activated
  end
end
