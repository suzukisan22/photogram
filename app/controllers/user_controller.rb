class UserController < ApplicationController
  def index
    @users = User.all
  end

  def search
    if params[:for] == 'user'
      @objects = User.where("username like '%" + params[:q] + "%'")
    else
      @objects = Picture.where("comment like '%" + params[:q] + "%'")
    end
  end
end
