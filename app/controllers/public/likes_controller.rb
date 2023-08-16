class Public::LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    like.save

    likes = Like.where(user_id: current_user.id).pluck(:post_id)
    @liked_posts = Post.find(likes)
    @following_posts = Post.where(user_id: [*current_user.following_ids], displayed: :true)
    # redirect_back fallback_location: root_path
    # ajax
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy

    likes = Like.where(user_id: current_user.id).pluck(:post_id)
    @liked_posts = Post.find(likes)
    @following_posts = Post.where(user_id: [*current_user.following_ids], displayed: :true)
    # redirect_back fallback_location: root_path
    # ajax
  end
end
