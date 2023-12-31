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
    if !session[:user_id]
      # redirect_to login_path
      render 'components/not_logged_in_page'
    else
      user_info()
      @comments = @tweet.comments.reverse
    end
  end

  def destroy
    # find tweet by id
    # delete tweet
    user_info()
    @tweet.destroy
    redirect_to root_path
  end

  #Likes
  def create_like
    user_info()
    @like = Like.new(user_id: @user.id, tweet_id: @tweet.id)
    done_with_like()
  end

  def unlike_tweet
    user_info()
    @like = Like.find_by(user_id: @user.id, tweet_id: @tweet.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def user_info
    @user = User.find(session[:user_id])
    @tweet = Tweet.find(params[:id])
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
