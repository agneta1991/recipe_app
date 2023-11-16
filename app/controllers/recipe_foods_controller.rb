class RecipeFoodsController < ApplicationController
  before_action :find_recipe


  def new
    @recipe_food = RecipeFood.new
    @foods = current_user.foods.where.not(id: @recipe.recipe_foods.pluck(:food_id))
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params.merge(recipe: @recipe))

    if @recipe_food.save
      redirect_to @recipe, notice: 'Food added to the recipe successfully!'
    else
      render :new, status: 422
    end
  end

  def destroy
    @recipe_food = @recipe.recipe_foods.find(params[:id])

    if @recipe_food.destroy
      redirect_to recipe_path(@recipe), notice: 'Food removed from the recipe successfully!'
    else
      redirect_to recipe_path(@recipe), alert: 'Error: Food could not be removed from the recipe'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :recipe_id, :quantity)
  end

  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
