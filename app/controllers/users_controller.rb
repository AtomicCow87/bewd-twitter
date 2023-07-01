class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render json: {
        user: {
          username: @user.username,
        }
      }
    else
      render json: {
        success: false
      }
    end
  end
end
