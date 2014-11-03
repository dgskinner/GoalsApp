class SessionsController < ApplicationController
  before_action :require_logged_in, only: :destroy
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(username: params[:user][:username])
      flash.now[:errors] = ["Invalid Username or Password"]
      render :new
    end
  end
  
  def destroy
    log_out!
    redirect_to new_session_url
  end
end
