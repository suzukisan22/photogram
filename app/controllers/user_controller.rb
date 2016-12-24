class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def search
    if params[:by] == 'user'
      @objects = User.where("username like '%" + params[:q] + "%'")
    else
      @objects = Picture.where("comment like '%" + params[:q] + "%'")
    end
  end
end
