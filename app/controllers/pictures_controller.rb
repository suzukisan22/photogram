class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture, only: [:show, :edit, :update, :destroy]


  def index
    @pictures = Picture.all.order(created_at: :desc)
    @users = User.all
    @num = 0
  end

  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    if @picture.comment.include?("#")
      tag_comments = @picture.comment.split(" ")
      tags = Array.new
      ct = 0

      tag_comments.each{|comment|
        tags.push(comment.gsub("#", "")) if comment.include?("#")
      }
    end
    @picture.user_id = current_user.id
    @picture.tag_list.add(tags)
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: '投稿の保存に成功しました' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: '投稿の更新に成功しました' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: '投稿の削除に成功しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:comment, :avatar)
    end
end
