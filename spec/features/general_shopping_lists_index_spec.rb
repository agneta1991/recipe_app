require 'rails_helper'

RSpec.describe 'GeneralShoppingLists', type: :feature do
  let(:user) { User.create(id: 1, name: 'Agneta', email: 'agneta@agneta.com', password: 'password') }

  def create_food(user, name, measurement_unit, price, quantity)
    Food.create(name: name, measurement_unit: measurement_unit, price: price, quantity: quantity, user_id: user.id)
  end

  describe 'GET /index' do
    before do
      create_food(user, 'Banana', 'kg', 3, 4)
      create_food(user, 'Grapes', 'kg', 2, 5)
      create_food(user, 'Apple', 'kg', 1, 6)

      sign_in user
      visit general_shopping_lists_path
    end

    it 'shows food names' do
      expect(page).to have_content('Banana')
      expect(page).to have_content('Grapes')
      expect(page).to have_content('Apple')
    end

    it 'shows quantity' do
      expect(page).to have_content('4')
      expect(page).to have_content('5')
      expect(page).to have_content('6')
    end

    it 'shows prices' do
      expect(page).to have_content('$3.00')
      expect(page).to have_content('$2.00')
      expect(page).to have_content('$1.00')
    end

    it 'shows the total amount' do
      expect(page).to have_content('$28.00')
    end

    it 'shows the amount of foods to buy' do
      expect(page).to have_content('3')
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
