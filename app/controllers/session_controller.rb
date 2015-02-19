class SessionController < ApplicationController
  def new
    redirect_to '/'
  end

  def create
    @user = User.find_by(handle: params[:username])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to "users/new"
    end
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
