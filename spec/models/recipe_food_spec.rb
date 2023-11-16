require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(id: 1, name: 'Bello', email: 'bello@bello.com', password: 'password') }

  def create_recipe(user, name, preparation_time, cooking_time, description, public)
    Recipe.create(name: name, preparation_time: preparation_time, cooking_time: cooking_time,
                  description: description, public: public, user_id: user.id)
  end

  describe 'validations' do
    let(:food) { Food.create(name: 'Flour', price: 2) }
    let(:recipe) { create_recipe(user, 'Banana pie', 1, 2, 'Add ingredients and bake it!', true) }

    it 'is valid with valid attributes' do
      recipe_food = RecipeFood.new(recipe: recipe, food: food, quantity: 3)
      expect(recipe_food).to be_valid
    end

    it 'is not valid with a negative quantity' do
      recipe_food = RecipeFood.new(recipe: recipe, food: food, quantity: -1)
      expect(recipe_food).not_to be_valid
      expect(recipe_food.errors[:quantity]).to include('must be greater than or equal to 0')
    end

    it 'is not valid with a string and not a number for quantity' do
      recipe_food = RecipeFood.new(recipe: recipe, food: food, quantity: 'four')
      expect(recipe_food).not_to be_valid
    end
  end
end
