class AddAPITokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_token, :string, index: true
    # Ensure that the user has an API token
    User.all.each do |user|
      user.api_token = SecureRandom.urlsafe_base64(32) unless user.api_token
      user.save!
    end
  end
end
