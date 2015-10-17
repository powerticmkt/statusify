class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :email
      t.boolean :activated, default: false
      t.string :activation_key

      t.timestamps null: false
    end
  end
end
