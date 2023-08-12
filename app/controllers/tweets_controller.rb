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

  private
  def user_info
    @user = User.find(session[:user_id])
    @following = @user.friends.count
    @followers = Friendship.where(friend_id: @user.id).count
  end
end
