require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) do
      User.create(
        first_name: 'Nate',
        last_name: 'Dog',
        email: 'frossy@fits.net',
        password: 'nahmate',
        password_confirmation: 'nahmate'
      )
    end
    it 'should be valid when created with valid credentials' do
      expect(user).to be_valid
    end
    it 'should not be valid when passwords don\'t match' do
      user.password_confirmation = 'nahmate1'
      user.valid?
      expect(user.errors.full_messages).to eq(['Password confirmation doesn\'t match Password'])
    end
  end
end