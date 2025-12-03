class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_post
  before_action :set_comment, only: [:destroy]
  before_action :authorize_comment_owner!, only: [:destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment added."
    else
      redirect_to @post, alert: "Comment could not be saved."
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment deleted."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

# only comment owner or admin can delete
  def authorize_comment_owner!
    unless @comment.user == current_user || current_user.role == "admin"
      redirect_to @post, alert: "Not authorized."
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
