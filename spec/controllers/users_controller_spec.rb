require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { user: { name: 'Test User', email: 'user@example.com', password: 'password' } } }

      it 'creates a new user' do
        expect {
          post :create, params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end

      it 'returns a success message' do
        post :create, params: valid_attributes
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('User created successfully')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { user: { email: 'invalid', password: 'short' } } }

      it 'does not create a new user' do
        expect {
          post :create, params: invalid_attributes
        }.not_to change(User, :count)
      end

      it 'returns an unprocessable entity status' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        post :create, params: invalid_attributes
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Email is invalid", "Password is too short (minimum is 6 characters)")
      end
    end
  end
end