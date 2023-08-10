class AuthController < ApplicationController

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(params.require(:user).permit(:name, :username, :email, :password))
    # @user = User.new(params.require(:user).permit(:active))
    if @user.save
      flash[:notice] = "Account Successfully created"
      redirect_to '/login'
    else
      render 'new_user', status: :unprocessable_entity
    end
  end

end
