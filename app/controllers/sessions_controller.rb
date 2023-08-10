class SessionsController < ApplicationController

  def new_session

  end

  def create_session
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Successful login"
      redirect_to root_path
    else
      flash.now[:alert] = "Bad Credentials. Try again"
      render 'new_session'
    end
  end

  def end_session
    session[:user_id] = nil
    flash[:notice] = "Logged Out"
    redirect_to '/login'
  end

end
