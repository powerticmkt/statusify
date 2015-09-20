class AssociateUsersAndIncidents < ActiveRecord::Migration
  def change
    change_table :incidents do |t|
      remove_column :incidents, :user_id
      t.belongs_to :user, index: true
    end
  end
end
