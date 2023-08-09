class AuthController < ApplicationController

  def login_form

  end


  def new_session
    @user = User.find_by(username: params[:username], password: params[:password_digest])
      @current_user = @user
      flash[:notice] = "Successful login"
    if !@user.valid?
      flash[:notice] = "Bad Credentials. Try again"
      render 'login'
    end
  end

  def create_session
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(params.require(:user).permit(:name, :username, :email, :password))
    # @user = User.new(params.require(:user).permit(:active))
    if @user.save
      flash[:notice] = "Account Successfully created"
      redirect_to root_path
    else
      render 'new_user', status: :unprocessable_entity
    end
  end

end
