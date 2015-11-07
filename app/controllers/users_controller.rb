class UsersController < ApplicationController

  before_filter :set_current_user, :only=> ['show', 'edit', 'update', 'delete']
  def user_params
    params.require(:user).permit(:first_name,:last_name,:password,:user_id, :email, :password_confirmation)
  end
  def show
    @user = User.find(params[:id])
  end

  def new
    # default: render 'new' template
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user.user_id}. Your account has been created."
      redirect_to login_path
    else
      render 'new'
    end
  end
end