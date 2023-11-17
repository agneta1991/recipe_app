class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @foods = @user.foods
  end

  def new
    @food = Food.new
    @foods = current_user.foods.all
  end

  def create
    @food = Food.new(food_params.merge(user_id: current_user.id))
    if @food.save
      redirect_to foods_path, notice: 'Food item was successfully created.'
    else
      render :new, status: 422
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
