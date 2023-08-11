class UserController < ApplicationController
  # signup
  def new_user
    @user = User.new
  end

  def create_user
    # create new user with params
    @user = User.new(params.require(:user).permit(:name, :username, :email, :password))
    # if user is valid then it saves
    if @user.save
      flash[:notice] = "Account Successfully created"
      # redirect to login page
      redirect_to '/login'
    else
      render 'new_user', status: :unprocessable_entity
    end
  end

  # login/session
  def new_session
  end

  def create_session
    # find user by username
    user = User.find_by(username: params[:user][:username])
    # check password
    if user && user.authenticate(params[:user][:password])
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

  # user profile
  def show_user
    @user = User.find(params[:id])
    @current_user = User.find(session[:user_id])
    @tweets = Tweet.where(user_id: @user.id)
  end

  def follow_user
    # friend = User.find(params[:id])
    current_user = User.find(session[:user_id])
    current_user.friendships.build(friend_id: params[:id])
    if current_user.save
      flash[:notice] = 'Now Following'
      redirect_to root_path
    else
      flash[:notice] = 'Something went wrong'
      redirect_to root_path
    end
  end

end
