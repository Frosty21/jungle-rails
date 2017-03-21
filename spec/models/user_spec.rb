require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) do
      User.create!(
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
      it 'should not be valid when passwords don\'t match' do
        user.password_confirmation = nil
        user.password_confirmation = nil
        user.valid?
        expect(user.errors.full_messages).to eq(['Password confirmation doesn\'t match Password that cant be blank'])
    end
    it 'should not be valid if the email is already in use' do
      user
      user2 = User.new(
        first_name: 'mary',
        last_name: 'jane',
        email: 'frossy@fits.net',
        password: 'nahmate',
        password_confirmation: 'nahmate'
      )
      user2.valid?
      expect(user2.errors.full_messages).to eq(['Email has already been taken'])
    end
    it 'should not be valid without an email' do
      user.email = nil
      user.valid?
      expect(user.errors.full_messages).to eq(["Email can't be blank"])
    end
    it 'should not be valid without a first name' do
      user.first_name = nil
      user.valid?
      expect(user.errors.full_messages).to eq(["First name can't be blank"])
    end
    it 'should not be valid without a last name' do
      user.last_name = nil
      user.valid?
      expect(user.errors.full_messages).to eq(["Last name can't be blank"])
    end
    it 'should have a password over 6 characters' do
      user.password = 'iknow'
      user.password_confirmation = 'iknow'
      user.valid?
      expect(user.errors.full_messages).to eq(
        ['Password is too short (minimum is 6 characters)']
      )
    end
  end
  describe '.authenticate_with_credentials' do
    before do
      User.create!(
        first_name: 'Han',
        last_name: 'Solo',
        email: 'millenium@falcon.net',
        password: 'easychewie',
        password_confirmation: 'easychewie'
      )
    end
    it 'should log in a user who enters valid credentials' do
      expect(User.authenticate_with_credentials('millenium@falcon.net', 'easychewie')).to be_truthy
    end
    it 'should reject login for a nonexistant e-mail' do
      expect(User.authenticate_with_credentials('tiefighter@empire.net', 'easychewie')).to be_nil
    end
    it 'should reject login for an incorrect password' do
      expect(User.authenticate_with_credentials('millenium@falcon.net', '34$ych3w1e')).to be_nil
    end
  end
end