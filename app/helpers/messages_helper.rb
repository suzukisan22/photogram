module MessagesHelper
  def oponent(message)
    @user = User.find(message.user_id)
  end

  def sender_img(message)
    user = User.find(message.user_id)
    return image_tag(user.avatar, alt: user.name) if user.avatar?

    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name)
  end
end
