class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    render 'tweets/index'
  end

  def index_by_user
    token = cookies.signed[:twitclone_session_token]
    session = Session.find_by(token: token)

    if session
      @tweets = session.user.tweets
      render 'tweets/index' # can be omitted
    else
      render json: { tweet: [] }
    end
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
    @tweet = Tweet.find_by(id: params[:id])

    if @tweet&.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  private

  def task_params
    params.require(:tweet).permit(:message)
  end
end
