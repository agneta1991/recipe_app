require 'rails_helper'

RSpec.describe 'GeneralShoppingLists', type: :feature do
  let(:user) { User.create(id: 1, name: 'Agneta', email: 'agneta@agneta.com', password: 'password') }

  describe 'GET /index' do
    before do
      sign_in user
      visit general_shopping_lists_path
    end

    it 'shows food names' do
      unique_recipe_foods = [
        { food_name: 'Apple', quantity: 3, price: 1.99 },
        { food_name: 'Banana', quantity: 5, price: 0.99 }
      ]

      allow_any_instance_of(GeneralShoppingListsController).to receive(:index) do |controller|
        controller.instance_variable_set(:@unique_recipe_foods, unique_recipe_foods)
      end
      visit general_shopping_lists_path

      unique_recipe_foods.each do |recipe_food|
        expect(page).to have_content(recipe_food[:food_name])
      end
    end

    it 'shows quantity' do
      unique_recipe_foods = [
        { food_name: 'Apple', quantity: 3, price: 1.99 },
        { food_name: 'Banana', quantity: 5, price: 0.99 }
      ]

      allow_any_instance_of(GeneralShoppingListsController).to receive(:index) do |controller|
        controller.instance_variable_set(:@unique_recipe_foods, unique_recipe_foods)
      end
      visit general_shopping_lists_path

      unique_recipe_foods.each do |recipe_food|
        expect(page).to have_content(recipe_food[:quantity])
      end    end

    it 'shows prices' do
      unique_recipe_foods = [
        { food_name: 'Apple', quantity: 3, price: 1.99 },
        { food_name: 'Banana', quantity: 5, price: 0.99 }
      ]

      allow_any_instance_of(GeneralShoppingListsController).to receive(:index) do |controller|
        controller.instance_variable_set(:@unique_recipe_foods, unique_recipe_foods)
      end
      visit general_shopping_lists_path

      unique_recipe_foods.each do |recipe_food|
        expect(page).to have_content(recipe_food[:food_name])
      end
    end

    context 'Click' do
      it "redirects me to the my food list's page when I click on navigation bar link" do
        visit general_shopping_lists_path
        click_link 'Your Foods'
        expect(page).to have_current_path(foods_path)
      end
    end
  end
end
