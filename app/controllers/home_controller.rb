class HomeController < ApplicationController
  def home
    @user = User.find(session[:user_id])
    @tweets = Tweet.all.reverse
  end

  def new_tweet
    @tweet = Tweet.new
  end

  def create_tweet
    @tweet = Tweet.new(params.permit(:message))
    @tweet.user_id = session[:user_id]
    if @tweet.save
      flash[:notice] = "Tweet successful"
      redirect_to root_path
    else
      flash.now[:alert] = "Something went wrong"
    end
  end

  def show_tweet
    @tweet = Tweet.find(params[:id])
    @current_user = User.find(session[:user_id])

  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to root_path
  end


end
