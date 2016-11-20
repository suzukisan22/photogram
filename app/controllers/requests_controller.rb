class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:request][:sender_id])
    current_user.send_request!(@user)
    respond_to do |format|
      format.js { render :create }
    end
  end

  def destroy
    @user = Request.find(params[:id]).sender
    current_user.unsend(@user)
    respond_to do |format|
      format.js { render :destroy }
    end
  end
end
