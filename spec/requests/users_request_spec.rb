require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /users' do
    context 'with valid attributes' do
      let(:valid_attributes) { { name: 'Test User', email: 'user@example.com', password: 'password' } }

      it 'creates a new user' do
        expect {
          post '/users', params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'returns status code 201' do
        post '/users', params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
      end

      it 'returns a success message' do
        post '/users', params: { user: valid_attributes }
        expect(JSON.parse(response.body)['status']).to eq('User created successfully')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { email: 'invalid', password: 'short' } }

      it 'does not create a new user' do
        expect {
          post '/users', params: { user: invalid_attributes }
        }.not_to change(User, :count)
      end

      it 'returns status code 422' do
        post '/users', params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        post '/users', params: { user: invalid_attributes }
        expect(JSON.parse(response.body)['errors']).to include("Email is invalid", "Password is too short (minimum is 6 characters)")
      end
    end
  end
end