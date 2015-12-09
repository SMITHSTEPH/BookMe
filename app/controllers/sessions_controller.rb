class SessionsController < ApplicationController
  skip_before_filter :set_current_user
  
  def new
    puts "ON LOGIN"
    # default: render 'new' template
  end

  def create
    puts "Not suppposed"
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      #sign in and redirect to show page
      cookies.permanent[:session_token]= user.session_token
      redirect_to books_path
    else
      flash.now[:warning] = 'Invalid email/password combination'
      render 'new'
    end  
  end

  def destroy
    cookies.delete(:session_token) 
    puts "Looooooooged Out"
    @current_user=nil
    flash[:notice]= 'You have logged out'
    redirect_to login_path
  end
end
