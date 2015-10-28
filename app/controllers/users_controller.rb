class UsersController < ApplicationController
  before_action :require_login, :require_admin

  def new
    @user = User.new
    render layout: 'dashboard'
  end

  def create
    if user_params[:password] != user_params[:password_confirmation]
      flash[:danger] = 'Password does not match confirmation'
      redirect_to(new_user_path) && return
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

  def manage
    render layout: 'dashboard'
  end

  def delete
    @user = User.find_by_id(params[:id])
    if @user && @user.delete
      flash[:success] = 'Deleted the user successfully'
    else
      flash[:danger] = 'An error occured'
    end
    redirect_to manage_users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :admin, :password_confirmation)
  end

  def require_admin
    redirect_to root_path and return unless current_user.admin?
  end
end
