class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_right_user, only: [:show]

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
    @senders = current_user.get_requests
    @request = Request.find_by(sender_id: current_user.id, recipient_id: @user.id)
    @request.destroy
    @user.follow!(current_user)
    respond_to do |format|
      format.html { redirect_to request_path(current_user.id) }
      format.js { render :admit }
    end
  end

  def destroy
    @user = Request.find(params[:id]).sender
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
