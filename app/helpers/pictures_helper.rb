module PicturesHelper
  def getCommentOne(picture)
    @comment = picture.comments.build
  end

  def getCommentAll(picture)
    @comment = picture.comments
  end

  def getDiffTime(picture)
    require 'active_support'
    now = Time.current.strftime("%y/%m/%d %p %l:%M")
    create_at = picture.created_at.strftime("%y/%m/%d %p %l:%M")
    calc = now - create_at
    @timeDiff = calc
  end
end
