class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def show
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      @foods = @user.food_journals
    end
  end

  def index
    @user = User.find_by(id: session[:user_id])
    @foods = FoodJournal.where(:user_id => session[:user_id], date: Date.today.beginning_of_day..Date.today.end_of_day) if @user
    @the_date = Date.today;
    render :index

  end


  def new
    if session[:user_id]
      redirect_to '/'
    end
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    if @user.save
      redirect_to user_path
    else
      render :new
    end
  end





  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to new_user_path
  end


  def edit
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      @foods = @user.food_journals
    else
      redirect_to '/'
    end
  end

  def update
    @user = User.find_by(id: session[:user_id])
    @user.update(user_params)
    redirect_to edit_user_path(@user)
  end


  private
    def user_params
      params.require(:user).permit(:handle, :email, :password, :male , :age , :weight, :target, :height, :goal)
    end



end

#
# users GET    /users(.:format)                  users#index
#             POST   /users(.:format)                  users#create
#    new_user GET    /users/new(.:format)              users#new
#   edit_user GET    /users/:id/edit(.:format)         users#edit
#        user GET    /users/:id(.:format)              users#show
#             PATCH  /users/:id(.:format)              users#update
#             PUT    /users/:id(.:format)              users#update
#             DELETE /users/:id(.:format)              users#destroy
# food_journals GET    /food_journals(.:format)          food_journals#index
#             POST   /food_journals(.:format)          food_journals#create
# new_food_journal GET    /food_journals/new(.:format)      food_journals#new
# edit_food_journal GET    /food_journals/:id/edit(.:format) food_journals#edit
# food_journal GET    /food_journals/:id(.:format)      food_journals#show
#             PATCH  /food_journals/:id(.:format)      food_journals#update
#             PUT    /food_journals/:id(.:format)      food_journals#update
#             DELETE /food_journals/:id(.:format)      food_journals#destroy
#        root GET    /                                 users#index
#    register GET    /register(.:format)               users#new
#     session POST   /session(.:format)                session#create
#             DELETE /session(.:format)                session#destroy
