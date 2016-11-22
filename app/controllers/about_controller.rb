class AboutController < ApplicationController
  def index
    @user = User.find_by(username: params[:username])
    @pictures = @user.pictures
  end

  def following
    @user = User.find_by(username: params[:username])
    @followings = @user.followed_users
  end

  def follower
    @user = User.find_by(username: params[:username])
    @followers = @user.followers
  end

end
