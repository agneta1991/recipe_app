class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
