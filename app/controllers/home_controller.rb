class HomeController < ApplicationController

  def home
    if !session[:user_id]
      # redirect_to login_path
      render 'components/not_logged_in_page'
    else
      # show tweets from the user they are following
      user_info()
      @tweets = Tweet.where(user_id: @user.friends.all).or(Tweet.where(user_id: @user.id)).reverse
    end
  end

  def for_you_tweets
    if !session[:user_id]
      # redirect_to login_path
      render 'components/not_logged_in_page'
    else
       # show tweets from the user that the current user isnt following
      user_info
      @tweets = Tweet.where.not(user_id: @user.friends.all).and(Tweet.where.not(user_id: @user.id)).reverse
    end
  end

  def new_tweet
    @tweet = Tweet.new
  end

  def create_tweet
    @tweet = Tweet.new(params.permit(:message, :image))
    @tweet.user_id = session[:user_id]
    if @tweet.save
      # flash[:notice] = "Tweet successful"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = "Something went wrong"
    end
  end

  private
  def user_info
    @user = User.find(session[:user_id])
    @following = @user.friends.count
    @followers = Friendship.where(friend_id: @user.id).count
  end

end
