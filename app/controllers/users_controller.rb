class UsersController < ApplicationController
#disabling CSRF
  skip_forgery_protection

  def new
    @user = User.new
  end

#no validation
#no sanitization
#password stored in plain text
#user role spoofing
  def create
    @user = User.new(
      email: params[:user][:email],
      password: params[:user][:password],
      display_name: params[:user][:display_name],
      role: params[:user][:role]
    )

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

#anyone can view any user's information
  def show
    @user = User.find(params[:id])
  end

#anyone can edit any user (IDOR vulnerability)
  def edit
    @user = User.find(params[:id])
  end

#no validation
#privilege escalation (attacker can set role=admin)
#password stored in plain text
  def update
    @user = User.find(params[:id])
    @user.update(
      email: params[:user][:email],
      password: params[:user][:password],
      display_name: params[:user][:display_name],
      role: params[:user][:role]
    )
    redirect_to @user
  end


end

