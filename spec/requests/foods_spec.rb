require 'spec_helper'

RSpec.describe 'Foods', type: :request do
  let(:current_user) { User.create(id: 2, name: 'Agneta', email: 'agneta@agneta.com', password: 'password') }


  describe 'GET /index' do
    before do
      sign_in current_user
      get foods_path
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      expect(response).to render_template('foods/index')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('<h1>Your Foods</h1>')
    end
  end
end
