class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save!
      user.set_api_key
      render json: UserSerializer.new(user), status: 201
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end