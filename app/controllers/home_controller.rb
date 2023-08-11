class HomeController < ApplicationController
  def home
    @user = User.find(session[:user_id])
    @tweets_following = Tweet.where(user_id: @user.friendships).reverse
    @tweets_for_you = Tweet.all.reverse
    @following = @user.friends.count
    @followers = Friendship.where(friend_id: @user.id).count
  end

  def new_tweet
    @tweet = Tweet.new
  end

  def create_tweet
    @tweet = Tweet.new(params.permit(:message))
    @tweet.user_id = session[:user_id]
    if @tweet.save
      # flash[:notice] = "Tweet successful"
      redirect_to root_path
    else
      flash.now[:notice] = "Something went wrong"
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
