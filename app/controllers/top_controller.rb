class TopController < ApplicationController
  def index
    if !user_signed_in?
      render :layout => 'top'
    else
      redirect_to pictures_path
    end
  end
end
