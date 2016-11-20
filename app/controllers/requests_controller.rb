class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:request][:sender_id])
    current_user.send_request!(@user)
    respond_to do |format|
      format.js { render :create }
    end
  end

  def show
    @user = User.find(params[:id])
    @senders = @user.get_requests
  end

  def admit
    @user = User.find(params[:id])
    @request = current_user.requests.find_by(recipient_id: current_user.id)
    binding.pry
    current_user.unsend(@user)
    @user.follow!(current_user)
    respond_to do |format|
      format.js {}
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
