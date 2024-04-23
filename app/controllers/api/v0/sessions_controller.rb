class Api::V0::SessionsController < ApplicationController
  def create
    
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      render json: UserSerializer.new(user), status: 201
    else
      invalid_user
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def invalid_user
    User.find(session_params)
  end
end