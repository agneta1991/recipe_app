require 'rails_helper'
RSpec.describe 'Recipe', type: :feature do
  let(:user) { User.create(id: 1, name: 'Toyyib', email: 'bello@bello.com', password: 'password') }
  def create_recipe(user, name, preparation_time, cooking_time, description, public)
    Recipe.create(name: name, preparation_time: preparation_time, cooking_time: cooking_time, description: description,
                  public: public, user_id: user.id)
  end
  describe 'GET /index' do
    before do
      create_recipe(user, 'Banana pie', 1, 4, 'Bake it', true)
      create_recipe(user, 'Apple pie', 2, 3, 'Delicious', true)
      create_recipe(user, 'Mince pie', 5, 6, 'Yummy', false)
      sign_in user
      visit recipes_path
    end
    it 'shows recipe names' do
      expect(page).to have_content('Banana pie')
      expect(page).to have_content('Apple pie')
      expect(page).to have_content('Mince pie')
    end
    it 'shows description' do
      expect(page).to have_content('Bake it')
      expect(page).to have_content('Delicious')
      expect(page).to have_content('Yummy')
    end
    it 'shows a link for deleting recipe ' do
      visit recipes_path
      expect(page).to have_link('Delete')
    end
    it 'shows a link for adding a new recipe ' do
      visit recipes_path
      expect(page).to have_link('Add New Recipe')
    end
    context 'Click' do
      it 'redirects me to add new food item form page when I click on button add new recipe' do
        visit recipes_path
        click_link 'Add New Recipe'
        expect(page).to have_current_path(new_recipe_path)
      end
      it 'redirects to the correct recipe page when a recipe name is clicked' do
        recipe = Recipe.first
        visit recipes_path
        click_link recipe.name
        expect(page).to have_current_path(recipe_path(recipe))
      end
    end
  end
end
