class FoodJournalsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token

  def index
    @display_date = Date.parse(params[:date]).strftime("%m/%d/%Y")
    @the_date = Date.parse(params[:date])
    @user = User.find_by(id: session[:user_id])
    @foods = @user.food_journals.where(date: @the_date.beginning_of_day..@the_date.end_of_day)

      # @foods = FoodJournal.where(:user_id => session[:user_id], created_at: Time.now.midnight..(Time.now.midnight + 1.day))

      # @foods = FoodJournal.where(:all,
      # :conditions => {
      #   :user_id => session[:user_id],
      #   :created_at => today} )
  end

  def show
    @user = User.find_by(id: params[:id])
    @foods = @user.food_journals

  end

  def destroy
    @food = FoodJournal.find_by(id: params[:id])
    @food.destroy
    puts params[:date]
    if Date.parse(params[:date])
      @the_date = Date.parse(params[:date])
      redirect_to '/food_journals?date=' + @the_date.to_s
    else
      redirect_to "/"
    end
  end

  def create

    @food = FoodJournal.create(food_params)
    if @food.save

      if params[:date]
        @food.update(date: Date.parse(params[:date]).noon)
        redirect_to '/food_journals?date=' + Date.parse(params[:date]).to_s
      else
        @the_date = Date.today
        @food.update(date: @the_date)
        @foods = FoodJournal.where(:user_id => session[:user_id], date: Date.today.beginning_of_day..Date.today.end_of_day)
        render :file => "layouts/_food", :layout => false
      end

    else
      render status: 400, nothing: true
    end
  end

  def edit
    @user = User.find_by(id: session[:user_id])
    @food = FoodJournal.find_by(id: params[:id])
    @foods = [@food]
  end

  private
    def food_params
      params.require(:food_journal).permit(:food , :qty, :cals, :fat, :carbs, :protein, :user_id )
    end

end
