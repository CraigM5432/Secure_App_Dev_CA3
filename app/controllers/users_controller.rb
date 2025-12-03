class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = "user"   # prevent role spoofing

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Account created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

# only the owner or admin may edit/update
  def authorize_user!
    unless @user == current_user || current_user.role == "admin"
      redirect_to root_path, alert: "Not authorized."
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :display_name)
  end
end

