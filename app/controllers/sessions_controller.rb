class SessionsController < ApplicationController

  def new_session

  end

  def create_session
    # find user by username
    user = User.find_by(username: params[:session][:username])
    # check password
    if user && user.authenticate(params[:session][:password])
      # set session to logged in user
      session[:user_id] = user.id
      # display success notice
      flash[:notice] = "Successful login"
      # go back to home/dashboard
      redirect_to root_path
    else
      flash.now[:alert] = "Bad Credentials. Try again"
      render 'new_session'
    end
  end

  def end_session
    # set session to nil
    session[:user_id] = nil
    flash[:notice] = "Logged Out"
    # redirect back to login page
    redirect_to '/login'
  end

end
