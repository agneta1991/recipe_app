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
      expect(response.body).to include("<h1>Your Foods</h1>")
    end
  end

  # describe 'GET #show' do
  #   # Add similar tests as above for the 'show' action
  # end

  # describe 'GET #new' do
  #   # Add similar tests as above for the 'new' action
  # end

  # describe 'POST #create' do
  #   it 'renders a successful response' do
  #     post :create, params: { food: { name: 'Example Food', measurement_unit: 'Unit', price: 10, quantity: 1 } }
  #     expect(response).to redirect_to(foods_path)
  #   end

  #   # Add more tests for the 'create' action as needed
  # end

  # describe 'DELETE #destroy' do
  #   # Add tests for the 'destroy' action
  # end
end
