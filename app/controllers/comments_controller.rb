class CommentsController < ApplicationController
  # コメントを保存するアクションです
  def create
    # ログインユーザーに紐づけてインスタンスを生成
    @comment = current_user.comments.build(comment_params)
    @picture = @comment.picture
    respond_to do |format|
      if @comment.save
        format.html { redirect_to pictures_path, notice: 'コメントを投稿しました' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js { render :index }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:picture_id, :content)
    end
end
