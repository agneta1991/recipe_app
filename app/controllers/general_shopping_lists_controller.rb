class GeneralShoppingListsController < ApplicationController
  def index
    @user = current_user
    @foods = @user.foods
    @users_recipe_foods = RecipeFood.where(food: @foods)

    @unique_recipe_foods = @users_recipe_foods.group_by(&:food_id).map do |_food_id, recipe_foods|
      {
        food_name: recipe_foods.first.food.name,
        quantity: recipe_foods.sum(&:quantity),
        unit_price: recipe_foods.first.food.price,
        price: recipe_foods.first.food.price * recipe_foods.sum(&:quantity)
      }
    end

    @quantity = @unique_recipe_foods.count
    @total_amount = @unique_recipe_foods.sum { |recipe_food| recipe_food[:price] }
  end
end
