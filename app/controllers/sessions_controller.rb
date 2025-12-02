class SessionsController < ApplicationController
#Skipping CSRF protectionb  
skip_forgery_protection

  def new

  end

# SQL injection is enabled through authenticate () method
  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id     # no session hardening
      redirect_to root_path
    else
      @error = "Invalid login: #{params[:email]}"   # reflected XSS
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end

