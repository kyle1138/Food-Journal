class FoodJournalsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token

  def index
    @foods = FoodJournal.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @foods = @user.food_journals
  end

  def create
    puts food_params
    @food = FoodJournal.create(food_params)
    if @food.save
      render json @food
    else
      render status: 400, nothing: true
    end
  end

  private
    def food_params
      params.require(:food_journal).permit(:food , :qty, :cals, :fat, :carbs, :protein, :user_id )
    end

end
