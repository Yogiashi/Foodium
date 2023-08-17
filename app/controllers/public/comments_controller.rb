class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
  end
  
  def create
    @comments = Comment.all
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    # ajax
  end
  
  def destroy
    @comments = Comment.all
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
    # ajax
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
