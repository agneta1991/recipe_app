class PublicRecipesController < ApplicationController
  def index
    @public_recipes = if user_signed_in?
                        current_user.recipes.or(Recipe.where(public: true)).order(created_at: :desc)
                      else
                        Recipe.where(public: true).order(created_at: :desc)
                      end
  end
end
