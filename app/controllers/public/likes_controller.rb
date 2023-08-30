class Public::LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    like.save
    # ログインユーザーがいいねした投稿idを取得
    likes = Like.where(user_id: current_user.id).pluck(:post_id)
    # 公開中のいいねした投稿を取得
    @liked_posts = Post.where(id: likes, displayed: true)
    # フォローしているユーザーの公開中の投稿を取得
    @following_posts = Post.where(user_id: [*current_user.following_ids], displayed: true)
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
    likes = Like.where(user_id: current_user.id).pluck(:post_id)
    @liked_posts = Post.where(id: likes, displayed: true)
    @following_posts = Post.where(user_id: [*current_user.following_ids], displayed: true)
  end
end
