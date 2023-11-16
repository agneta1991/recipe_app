class GeneralShoppingListsController < ApplicationController
  def index
    @user = current_user
    @foods = @user.foods
    @quantity = Food.count
    @total_amount = Food.sum('quantity * price')
  end
end
