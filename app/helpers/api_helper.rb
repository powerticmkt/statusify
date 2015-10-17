module APIHelper
  def authenticate_user
    # Returns a User if an api_token is supplied and is valid
    if @request && @request['api_token']
      User.find_each do |u|
        if Devise.secure_compare(u.api_token, @request['api_token'])
          @user = u
        end
      end
    end
    @user
  end
end