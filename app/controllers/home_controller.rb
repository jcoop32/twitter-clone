class HomeController < ApplicationController

  def home
    @user = User.find(session[:user_id])
    # show tweets from the user they are following
    @tweets = Tweet.where(user_id: @user.friends.all).or(Tweet.where(user_id: @user.id)).reverse
    @following = @user.friends.count
    @followers = Friendship.where(friend_id: @user.id).count
  end

  def for_you_tweets
    @user = User.find(session[:user_id])
    # show tweets from the user that the current user isnt following
    @tweets = Tweet.where.not(user_id: @user.friends.all).reverse
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



end
