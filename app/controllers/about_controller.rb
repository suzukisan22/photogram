class AboutController < ApplicationController
  def index
    @user = User.find_by(username: params[:username])
    @pictures = @user.pictures
  end
end
