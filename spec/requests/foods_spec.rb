require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  let(:user) { User.create(id: 1, name: 'Agneta', email: 'agneta@agneta.com', password: 'password') }

  def create_food(user)
    Food.create(
      name: 'banana',
      measurement_unit: 'kg',
      price: 3,
      quantity: 3,
      user_id: user.id
    )
  end

  describe 'GET /index' do
    before do
      @user_food = create_food(user)
      sign_in user
      get foods_path
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('<h1>Your Foods</h1>')
    end
  end

  describe 'GET #new' do
    before do
      sign_in user
      get new_food_path
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

    it 'creates a new food' do
      expect do
        post foods_path, params: { food: { name: 'Example Food', measurement_unit: 'Unit', price: 10, quantity: 1 } }
      end.to change(Food, :count).by(1)
    end

    it 'redirects to foods_path' do
      post foods_path, params: { food: { name: 'Example Food', measurement_unit: 'Unit', price: 10, quantity: 1 } }
      expect(response).to redirect_to(foods_path)
    end
  end

  describe 'DELETE #destroy' do
    before do
      @user_food = create_food(user)
      sign_in user
    end

    it 'destroys the requested food' do
      expect do
        delete food_path(@user_food)
      end.to change(Food, :count).by(-1)
    end

    it 'redirects to the foods list' do
      delete food_path(@user_food)
      expect(response).to redirect_to(foods_path)
    end
  end
end
