require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(id: 1, name: 'Bello', email: 'bello@bello.com', password: 'password') }

  def create_recipe(user, name, preparation_time, cooking_time, description, public)
    Recipe.create(name: name, preparation_time: preparation_time, cooking_time: cooking_time,
                  description: description, public: public, user_id: user.id)
  end

  describe 'GET /index' do
    let(:recipe) { create_recipe(user, 'Banana pie', 1, 2, 'Add ingredients and bake it!', true) }

    describe 'validations' do
      it 'is valid with valid attributes' do
        expect(recipe).to be_valid
      end

      it 'is not valid without a name' do
        recipe.name = nil
        expect(recipe).to_not be_valid
        expect(recipe.errors[:name]).to include("can't be blank")
      end

      it 'is not valid with a negative preparation time' do
        recipe.preparation_time = -1
        expect(recipe).to_not be_valid
        expect(recipe.errors[:preparation_time]).to include('must be greater than or equal to 0')
      end

      it 'is not valid when preparation time is written as a string' do
        recipe.preparation_time = 'one'
        expect(recipe).to_not be_valid
      end

      it 'is not valid with a negative cooking time' do
        recipe.cooking_time = -2
        expect(recipe).to_not be_valid
        expect(recipe.errors[:cooking_time]).to include('must be greater than or equal to 0')
      end

      it 'is not valid when cooking time its written as a string' do
        recipe.cooking_time = 'two'
        expect(recipe).to_not be_valid
      end
    end
  end
end
