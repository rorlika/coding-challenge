require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'GET /users' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /users' do
    context 'with valid parameters' do
      let(:valid_attributes) { { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123' } } }

      it 'creates a new User' do
        expect {
          post users_path, params: valid_attributes
        }.to change(User, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { user: { email: '', password: '' } } }

      it 'does not create a new User' do
        expect {
          post users_path, params: invalid_attributes
        }.to change(User, :count).by(0)
      end
    end
  end
end