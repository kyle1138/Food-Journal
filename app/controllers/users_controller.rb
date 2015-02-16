class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  def show
    @user = User.find_by(id: session[:user_id])
    @foods = @user.food_journals
  end

  def index
    @user = User.find_by(id: session[:user_id])
   if @user
     @foods = @user.food_journals
     render :show
   else
     redirect_to '/login'
   end
  end




  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to user_path(@user)
  end


  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to users_path
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end


  private
    def user_params
      params.require(:user).permit(:headline, :content, :photo_url)
    end



end
