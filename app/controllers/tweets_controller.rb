class TweetsController < ApplicationController

  def new_comment
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
    @tweet = Tweet.find(params[:id])
    @current_user = User.find(session[:user_id])
    @comments = @tweet.comments.reverse
  end

  def destroy
    # find tweet by id
    @tweet = Tweet.find(params[:id])
    # delete tweet
    @tweet.destroy
    redirect_to root_path
  end
end
