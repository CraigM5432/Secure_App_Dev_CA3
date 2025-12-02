class PostsController < ApplicationController
#disabling CSRF protection  
skip_forgery_protection

  def index
    @posts = Post.all
  end

  def show
# Allowing SQL Injection
    @post = Post.find_by_sql("SELECT * FROM posts WHERE id = #{params[:id]}").first
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

#no validations 
#stored XSS
# user spoofing
  def create
    @post = Post.new(
      title: params[:post][:title],
      body: params[:post][:body],
      user_id: params[:post][:user_id]   # anyone can claim to be any user_id
    )

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end
# any user can delete any post 
  def destroy
#cascading delete manually
   Comment.where(post_id: params[:id]).delete_all
   Post.delete(params[:id])

   redirect_to posts_path
  end
#anyone can edit any post 
  def edit
  @post = Post.find(params[:id])
  end

#no validation
#no sanitization
#stored XSS
def update
  @post = Post.find(params[:id])
  @post.update(
    title: params[:post][:title],
    body: params[:post][:body],
    user_id: params[:post][:user_id]  # user id spoofing
  )

  redirect_to @post
end


end

