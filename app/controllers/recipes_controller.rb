class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:toggle_public]
  # before_action :authenticate_user!

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.foods.includes(:recipe_foods)
  end

  def new
    @recipe = Recipe.new
    @recipes = current_user.recipes.all
  end

  def create
    public_param = params[:recipe][:public] == '1'
    @recipe = Recipe.new(recipe_params.merge(user_id: current_user.id, public: public_param))

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully added.'
    else
      render :new, status: 422
    end
  end

  def destroy
    @recipe = current_user.recipes.find_by(id: params[:id])

    if @recipe.destroy
      redirect_to recipe_path, notice: 'Recipe deleted successfully'
    else
      redirect_to recipe_path, alert: 'Error: could not be deleted'
    end
  end

  def toggle_public
    @recipe = Recipe.find_by(id: params[:id])
    new_public_state = !@recipe.public
    if @recipe.update(public: new_public_state)
      respond_to do |format|
        format.html {
          redirect_to recipe_path(@recipe), notice: 'Recipe public status updated successfully!'
        }
        format.js
      end
    else
      repsond_to do |format|
        format.html {
          redirect_to recipe_path(@recipe), alert: 'Error: Recipe public status could not be updated'
        }
        format.js
      end
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
