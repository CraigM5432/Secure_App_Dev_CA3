class PostsController < ApplicationController
  before_action :require_login
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

# only owner OR admin can edit/delete
  def authorize_owner!
    unless @post.user == current_user || current_user.role == "admin"
      redirect_to posts_path, alert: "Not authorized."
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
