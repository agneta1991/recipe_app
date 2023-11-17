require 'rails_helper'
RSpec.describe 'Recipes', type: :request do
  let(:user) { User.create(id: 1, name: 'Bello', email: 'Bello@Bello.com', password: 'password') }
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
    end
    it 'renders a successful response' do
      get recipes_path
      expect(response).to be_successful
    end
    it 'renders the correct template' do
      get recipes_path
      expect(response).to render_template('index')
    end
    it 'includes correct placeholder text in the response body' do
      get recipes_path
      expect(response.body).to include('<h1>My Recipes</h1>')
    end
  end
  describe 'GET #show' do
    before do
      sign_in user
      @recipe = create_recipe(user, 'Test Recipe', 1, 1, 'Test Description', true)
      get recipe_path(@recipe)
    end
    it 'renders a successful response' do
      expect(response).to be_successful
    end
    it 'renders the correct template' do
      expect(response).to render_template('show')
    end
    it 'assigns the requested recipe to @recipe' do
      expect(assigns(:recipe)).to eq(@recipe)
    end
    it 'assigns the recipe foods to @recipe_foods' do
      expect(assigns(:recipe_foods)).to eq(@recipe.recipe_foods)
    end
    it 'includes the recipe name in the response body' do
      expect(response.body).to include(@recipe.name)
    end
  end
  describe 'GET #new' do
    before do
      sign_in user
      get new_recipe_path
    end
    it 'renders a successful response' do
      expect(response).to be_successful
    end
    it 'renders the correct template' do
      expect(response).to render_template('new')
    end
  end
  describe 'POST #create' do
    before do
      sign_in user
    end
    it 'creates a new recipe' do
      expect do
        post recipes_path,
             params: { recipe: { name: 'banana pie', preparation_time: 1, cooking_time: 1, description: 'Bake it',
                                 public: true } }
      end.to change(Recipe, :count).by(1)
    end
    it 'redirects to recipes_path' do
      post recipes_path,
           params: { recipe: { name: 'banana pie', preparation_time: 1, cooking_time: 1, description: 'Bake it',
                               public: true } }
      expect(response).to redirect_to(recipes_path)
    end
  end
  describe 'DELETE #destroy' do
    before do
      @user_food = create_recipe(user, 'Some Food', 1, 1, 'Delicious', true)
      sign_in user
    end
    it 'destroys the requested food' do
      expect do
        delete recipe_path(@user_food)
      end.to change(Recipe, :count).by(-1)
    end
    it 'redirects to the recipes list' do
      delete recipe_path(@user_food)
      expect(response).to redirect_to(recipe_path)
    end
  end
end
