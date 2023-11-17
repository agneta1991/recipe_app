class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:toggle_public]

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
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

  def update
    @recipe = current_user.recipes.find(params[:id])
    public_param = params[:recipe][:public] == '1'
  
    if @recipe.update(recipe_params.merge(public: public_param))
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully updated.'
    else
      render :edit
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

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def recipe_params_public
    params.require(:recipe).permit(:public)
  end
end
