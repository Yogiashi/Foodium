class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
  end

  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    # フォローしているユーザーの公開中の投稿を取得
    @following_posts = Post.where(user_id: [*current_user.following_ids], displayed: true).page(params[:following_page]).per(12).order(created_at: :desc)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
    Comment.find(params[:id]).destroy
    # フォローしているユーザーの公開中の投稿を取得
    @following_posts = Post.where(user_id: [*current_user.following_ids], displayed: true).page(params[:following_page]).per(12).order(created_at: :desc)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
