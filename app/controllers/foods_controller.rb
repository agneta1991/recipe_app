class FoodsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @foods = @user.foods
  end

  def show
    @user = current_user
    @food = @user.foods
  end

  def new
    @food = Food.new
    @foods = current_user.foods.all
  end

  def create
    puts current_user.id
    @food = Food.new(
      name: food_params[:name],
      measurement_unit: food_params[:measurement_unit],
      price: food_params[:price],
      quantity: food_params[:quantity],
      user_id: current_user.id
    )

    if @food.save
      redirect_to foods_path, notice: 'Food item was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to foods_path, notice: 'Food item was successfully deleted.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
