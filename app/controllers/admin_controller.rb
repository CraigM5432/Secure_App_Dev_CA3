class AdminController < ApplicationController
#Insecure  
skip_forgery_protection

#Any user can access admin pages without being an admin
  def dashboard
    @users = User.all
    @posts = Post.all
    @comments = Comment.all
  end

#Any user can delete any user
  def delete_user
    User.delete(params[:id])
    redirect_to "/admin/dashboard"
  end

#Any user can delete any post
  def delete_post
    Post.delete(params[:id])
    redirect_to "/admin/dashboard"
  end

#Any user can delete any comment
  def delete_comment
    Comment.delete(params[:id])
    redirect_to "/admin/dashboard"
  end
end
