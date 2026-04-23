require 'rails_helper'
RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:encrypted_password) }
  
  describe 'Devise modules' do
    it { should respond_to(:valid_password?) }
    it { should respond_to(:send_reset_password_instructions) }
    it { should respond_to(:remember_me) }
  end
end