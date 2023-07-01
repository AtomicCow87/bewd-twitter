class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    render 'tweets/index'
  end

  def index_by_user
    @user = User.find_by(username: params[:username])
    @tweets = @user.tweets.order(created_at: :desc)
    render 'tweets/index'
  end

  def create
    token = cookies.signed[:twitclone_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = user.tweet.new(tweet_params)

      if @tweet.save
        render 'tweets/create' # can be omitted
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end

  def destroy
    token = cookies.signed[:twitclone_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = user.tweets.find_by(id: params[:id])

      if @tweet&.destroy
        render json: { success: true }
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
    end
  end

  private

  def task_params
    params.require(:tweet).permit(:message)
  end
end
