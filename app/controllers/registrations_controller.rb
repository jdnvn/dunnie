class RegistrationsController < ApplicationController
  def create
    user = User.create!(
      username: params['user']['username'],
      password: params['user']['password'],
      password_confirmation: params['user']['password_confirmation']
    )

    if user
      session[:user_id] = user.id
      render json: { status: :success, user: user }
    else
      render json: { status: :unprocessable_entity }
    end
  end
end
