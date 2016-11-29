module MessagesHelper
  def oponent(message)
    @user = User.find(message.user_id)
  end
end
