require 'rails_helper'

describe User, type: :model do
  it 'validates email format' do
    user = User.new(email: 'invalid', password: 'password')
    expect(user.valid?).to be_falsey
  end

  it 'validates password length' do
    user = User.new(email: 'test@example.com', password: 'short')
    expect(user.valid?).to be_falsey
  end
end