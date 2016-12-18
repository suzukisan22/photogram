class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_right_user, only: [:show]

  def create
    @user = User.find(params[:request][:recipient_id])
    current_user.send_request!(@user)
    respond_to do |format|
      format.js { render :create }
    end
  end

  def show
    @user = User.find(params[:id])
    @requests = Request.where(recipient_id: @user.id)
  end

  def admit
    @request = Request.find(params[:request][:id])
    @user = User.find(params[:request][:sender_id])
    @request.destroy
    @user.follow!(current_user)
    respond_to do |format|
      format.js { render :admit }
    end
  end

  def destroy
    @user = Request.find(params[:id]).recipient
    current_user.unsend(@user)
    respond_to do |format|
      format.js { render :destroy }
    end
  end

  private
    def is_right_user
      @user = User.find(params[:id])
      if current_user.id != @user.id
        redirect_to pictures_path
      end
    end

end
