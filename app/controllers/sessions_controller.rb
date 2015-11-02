class SessionsController < ApplicationController

  def session_params
    params.require(:user).permit(:user_id, :email)
  end
  
  def new
    # default: render 'new' template
  end

  def create
    user = User.find_by_email(session_params[:email])
    if user != nil && User.exists?(:user_id => user.user_id) && User.exists?(:email => user.email)
      session[:session_token] = user.session_token
      redirect_to movies_path
    else
      flash[:notice] = "invalid user-id/email combination"
      redirect_to login_path
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to movies_path
  end
end
