class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :incidents

  # Ensure that the user has a valid API token
  # An API token is a 32-char base64 string
  before_create do
    self.api_token = SecureRandom.urlsafe_base64(32)
  end

end
