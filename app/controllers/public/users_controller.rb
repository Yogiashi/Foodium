class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :draft]

  def index
    if params[:word]
      @users = User.search(params[:word]) #ユーザー検索フォームから送られた値を代入
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @posts = @user.posts.where(displayed: true).page(params[:posts_page]).per(12).order(created_at: :desc) #公開中の投稿を取得
    likes = Like.where(user_id: current_user.id).pluck(:post_id) #ログインユーザーがいいねした投稿idを取得
    @liked_posts = Post.where(id: likes, displayed: true).page(params[:liked_page]).per(12).order(created_at: :desc) #公開中のいいねした投稿を取得
  end
  
  # 下書きアクション
  def draft
    @user = User.find(params[:id])
    @posts = @user.posts.where(displayed: false).page(params[:page]).per(12).order(created_at: :desc) #非公開中の投稿を取得
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
  
  # 退会アクション
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)  # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to new_user_registration_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # urlから直接アクセスされるのを防ぐ
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end
end
