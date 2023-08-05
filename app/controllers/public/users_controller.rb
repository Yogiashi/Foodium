class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @posts = current_user.posts
    # いいねした投稿を取得
    likes = Like.where(user_id: current_user.id).pluck(:post_id)
    @liked_posts = Post.find(likes)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました。"
    else
      render "edit"
    end
  end
  
  def withdraw
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to new_user_registration_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
