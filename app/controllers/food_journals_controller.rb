class FoodJournalsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token
  require 'httparty'

  def index

    @display_date = Date.parse(params[:date]).strftime("%m/%d/%Y")
    @the_date = Date.parse(params[:date])
    @user = User.find_by(id: session[:user_id])
    @foods = @user.food_journals.where(date: @the_date.beginning_of_day..@the_date.end_of_day)

  end


  def show
    def send_simple_message
    RestClient.post "https://api:key-45353bea761148676ae6fbb927af15b5"\
    "@api.mailgun.net/v2/sandbox471d5fcdac604d1baef1aac24fbe0849.mailgun.org/messages",
    :from => "Mailgun Sandbox <postmaster@sandbox471d5fcdac604d1baef1aac24fbe0849.mailgun.org>",
    :to => "Kyle Hogan <kylehogan1980@yahoo.com>",
    :subject => "Hello from DropBox test",
    :text => "Congratulations Kyle Hogan, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
    end

    urlOne = "https://api.nutritionix.com/v1_1/search/";
    urlTwo = "?item_type=3&results=0%3A20&cal_min=0&cal_max=5000&fields=item_name%2Cnf_dietary_fiber%2Cbrand_name%2Cnf_calories%2Cnf_serving_size_qty%2Cnf_serving_size_unit%2Cnf_total_fat%2Cnf_total_carbohydrate%2Cnf_protein%2Cnf_serving_weight_grams%2Citem_id%2Cbrand_id&appId=bdcc47ce&appKey=e53cc81b43727bf30f6ffb0a54ab80a8"
    instaURL = "https://api.instagram.com/v1/tags/food/media/recent?client_id=8fe4db31e3a940068664c1e7e3c5c061"
    food = (params[:food])
    # foodsNutrix = HTTParty.get(instaURL)
    foodsNutrix = HTTParty.get(urlOne + URI.encode(food) + urlTwo)
    @user = User.find_by(session[:user_id])
    @foods = @user.food_journals

		    respond_to do |format|

	         format.json { render json: foodsNutrix }

	     end

  end


  def destroy
    @food = FoodJournal.find_by(id: params[:id])
    @food.destroy

    if params[:date] != ''
      @the_date = Date.parse(params[:date])
      redirect_to '/food_journals?date=' + @the_date.to_s
    else
      redirect_to edit_user_path
    end
  end





  def create

    @food = FoodJournal.create(food_params)
    if @food.save

      if params[:date]
        @food.update(date: Date.parse(params[:date]).noon)
        @foods = FoodJournal.where(:user_id => session[:user_id], date: Date.parse(params[:date]).beginning_of_day..Date.parse(params[:date]).end_of_day)
        render :file => "layouts/_food", :layout => false
        # redirect_to '/food_journals?date=' + Date.parse(params[:date]).to_s
      else
        @the_date = Date.today
        @food.update(date: @the_date)
        @foods = FoodJournal.where(:user_id => session[:user_id], date: Date.today.beginning_of_day..Date.today.end_of_day)
        render :file => "layouts/_food", :layout => false
      end

    else
      @foods = FoodJournal.where(:user_id => session[:user_id], date: Date.today.beginning_of_day..Date.today.end_of_day)
      render :file => "layouts/_food", :layout => false

    end
  end

  def edit
    @user = User.find_by(id: session[:user_id])
    @food = FoodJournal.find_by(id: params[:id])
    @foods = [@food]
  end


  private
    def food_params
      params.require(:food_journal).permit(:food , :qty, :cals, :fat, :carbs, :protein, :user_id ,)
    end


end
