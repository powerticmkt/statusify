class PagesController < ApplicationController
  before_action :require_login, only: [:create_user]

  def index
  end

  def history
    # The incident history. Shows all the ancient incidents since the index page shows only five of them.
    @dated_incidents = dated_incidents
    # Render the dashboard layout if signed in
    if signed_in?
      render 'pages/history', layout: 'dashboard'
    end
  end

  def current_status_dot
    if active_incidents.blank?
      url = "#{Statusify.app_url}/up.svg"
    else
      url = "#{Statusify.app_url}/down.svg"
    end
    redirect_to url
  end

  def new_user
    redirect_to root_path and return unless current_user.admin?
    @user = User.new
    render layout: 'dashboard'
  end

  def create_user
    redirect_to root_path unless current_user.admin?
    if user_params[:password] != user_params[:password_confirmation]
      flash[:danger] = 'Password does not match confirmation'
      redirect_to new_user_path and return
    end
    @user = User.new
    @user.email = user_params[:email]
    @user.password = user_params[:password]
    if @user.save
      flash[:success] = 'Created the user successfully'
      redirect_to root_path
    else
      flash[:danger] = @user.errors.full_messages.join(', ').capitalize
      redirect_to new_user_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :admin, :password_confirmation)
  end
end
