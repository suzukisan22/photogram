module UserHelper
  def getObject(object)
    return object.username if params[:by] == 'user'
    return image_tag("#{object.avatar.url}") if params[:by] == 'picture'
  end
end
