class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    # フォローしてるユーザーの投稿を取得
    @following_posts = Post.where(user_id: [*current_user.following_ids])
  end

  def show
  end

  def edit
  end
  
  private
  def post_params
    params.require(:post).permit(:post_image, :shop_name, :dish_name, :caption)
  end
end
