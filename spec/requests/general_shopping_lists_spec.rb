require 'rails_helper'

RSpec.describe 'GeneralShoppingLists', type: :request do
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
      get general_shopping_lists_path
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('<h1>Shoppin list</h1>')
    end

    it 'assigns the correct values to instance variables' do
      user = User.create(id: 1, name: 'Agneta', email: 'agneta@agneta.com', password: 'password')
      food1 = Food.create(name: 'Banana', measurement_unit: 'kg', price: 3, quantity: 2, user_id: user.id)
      food2 = Food.create(name: 'Apple', measurement_unit: 'kg', price: 2, quantity: 3, user_id: user.id)
      food3 = Food.create(name: 'Strawberry', measurement_unit: 'kg', price: 1, quantity: 2, user_id: user.id)

      sign_in user
      get general_shopping_lists_path
      expect(response).to be_successful

      expect(assigns(:quantity)).to eq(4)
      expect(assigns(:total_amount)).to eq(0.23e2)
    end
  end
end
