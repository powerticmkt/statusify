class CleanupClearance < ActiveRecord::Migration
  def change
    # Remove unneeded Clearance columns
    remove_column :users, :remember_token
    remove_column :users, :confirmation_token
  end
end
