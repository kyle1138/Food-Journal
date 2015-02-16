class SessionController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by(handle: params[:username])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to '/login'
  end
end
