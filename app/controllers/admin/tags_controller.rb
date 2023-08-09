class Admin::TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
      @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: "タグの登録に成功しました。"
    else
      @tags = Tag.all
      render :index
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
     @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: "タグの編集に成功しました。"
    else
      render :edit
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
