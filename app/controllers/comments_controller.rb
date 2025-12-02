class CommentsController < ApplicationController
# no CSRF protection  
skip_forgery_protection

#stored XSS
# user spoofing 
  def create
    @comment = Comment.new(
      body: params[:comment][:body],
      post_id: params[:post_id],
      user_id: params[:comment][:user_id]
    )

    @comment.save  # ignoring validation
    redirect_to post_path(params[:post_id])
  end
# no authentication
# no authorization
  def destroy
    Comment.delete(params[:id])
    redirect_to post_path(params[:post_id])
  end
end

