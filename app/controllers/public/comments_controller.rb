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
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
    Comment.find(params[:id]).destroy
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
