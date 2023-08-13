class TweetsController < ApplicationController

  def new_comment
    user_info()
    @comment = Comment.new
  end

  def create_comment
    @user = session[:user_id]
    @comment = Comment.new(params.permit(:message))
    @comment.user_id = @user
    @comment.tweet_id = params[:id]
    if @comment.save
      # flash[:notice] = "Tweet successful"
      redirect_to tweet_path
    else
      flash.now[:notice] = "Something went wrong"
    end
  end

  def show_tweet
    user_info()
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.reverse
  end

  def destroy
    # find tweet by id
    @tweet = Tweet.find(params[:id])
    # delete tweet
    @tweet.destroy
    redirect_to root_path
  end

  #Likes
  def create_like
    user_info()
    @tweet = Tweet.find(params[:id])
    @like = Like.new(user_id: @user.id, tweet_id: @tweet.id)
    done_with_like()
  end

  def unlike_tweet
    user_info()
    @tweet = Tweet.find(params[:id])
    @like = Like.find_by(user_id: @user.id, tweet_id: @tweet.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def user_info
    @user = User.find(session[:user_id])
    @following = @user.friends.count
    @followers = Friendship.where(friend_id: @user.id).count
  end

  def done_with_like
    if @like.save
      # flash[:notice] = "Tweet liked"
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "something went wrong"
    end
  end
end
