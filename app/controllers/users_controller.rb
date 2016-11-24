class UsersController < ApplicationController
  before_action :authenticate_user!
  def search
    @user = User.new
  end

  def result
    @user = User.new(user_params)
    @users = User.or(@user.email, @user.name, @user.username)
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :username)
    end

end
