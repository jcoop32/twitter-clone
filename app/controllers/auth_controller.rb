class AuthController < ApplicationController

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

end
