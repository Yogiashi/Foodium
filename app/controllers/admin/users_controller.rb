class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:word]
      @users = User.search(params[:word]).page(params[:page]).per(15)
    else
      @users = User.all.page(params[:page]).per(15)
    end
  end

  def posts
    @user = User.find(params[:user_id])
    @posts = @user.posts.where(displayed: true).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー情報の編集に成功しました。"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_deleted)
  end
end
