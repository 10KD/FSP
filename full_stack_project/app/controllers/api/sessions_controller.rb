class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.save
      login(@user)
      render "/root"
    else
      render json: ["invalid username or password"], status: 401
    end
  end

  def destroy
    @user = current_user
    if @user
      logout
      render "/root"
    else
      render json: ["there's no one to sign out"], status: 404
    end
  end
end
