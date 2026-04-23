require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('userexample.com').for(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'secure password' do
    it 'should have a secure password' do
      user = User.new(email: 'user@example.com', password: 'password')
      expect(user).to respond_to(:authenticate)
    end
  end
end