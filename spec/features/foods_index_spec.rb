require 'rails_helper'

RSpec.describe 'Food', type: :feature do
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
      visit foods_path
    end

    it 'shows food names' do
      expect(page).to have_content('Banana')
      expect(page).to have_content('Grapes')
      expect(page).to have_content('Apple')
    end

    it 'shows measurement unit' do
      expect(page).to have_content('kg')
    end

    it 'shows prices unit' do
      expect(page).to have_content('$3.00')
      expect(page).to have_content('$2.00')
      expect(page).to have_content('$1.00')
    end

    it 'shows a link for deleting a food item ' do
      visit foods_path
      expect(page).to have_link('Delete')
    end

    it 'shows a link for adding a food item ' do
      visit foods_path
      expect(page).to have_link('Add Food')
    end

    context 'Click' do
      it "redirects me to add new food item form page when I click on button add food" do
        visit foods_path
        click_link 'Add Food'
        expect(page).to have_current_path(new_food_path)
      end
    end
  end
end
