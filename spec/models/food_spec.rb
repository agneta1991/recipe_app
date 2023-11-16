require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(id: 1, name: 'Agneta', email: 'agneta@agneta.com', password: 'password') }

  def create_food(user, name, measurement_unit, price, quantity)
    Food.create(name: name, measurement_unit: measurement_unit, price: price, quantity: quantity, user_id: user.id)
  end

  describe 'GET /index' do
    before do
      create_food(user, 'Banana', 'kg', 3, 4)
      create_food(user, 'Grapes', 'kg', 2, 5)
      create_food(user, 'Apple', 'kg', 1, 6)
    end

    it 'should be valid when price is a number' do
      food = Food.new(name: 'Orange', measurement_unit: 'kg', price: 5, quantity: 3, user_id: user.id)
      expect(food).to be_valid
    end

    it 'should be not valid when quantity is a not number' do
      food = Food.new(name: 'Orange', measurement_unit: 'kg', price: 5, quantity: 'a', user_id: user.id)
      expect(food).not_to be_valid
    end

    it 'should be valid when name is not blank' do
      food = Food.new(name: 'Orange', measurement_unit: 'kg', price: 5, quantity: 3, user_id: user.id)
      expect(food).to be_valid
    end

    it 'should be not valid when name is blank' do
      food = Food.new(name: '', measurement_unit: 'kg', price: 5, quantity: 3, user_id: user.id)
      expect(food).not_to be_valid
    end
  end
end
