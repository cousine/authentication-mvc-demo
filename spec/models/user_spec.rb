require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  context 'registration' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'should generate a hashed_password when password is added' do
      expect(@user.hashed_password).not_to be nil
      
      expect(
        User.generate_password_hash(@user.password, @user.password_seed)
      ).to eq @user.hashed_password
    end

    it 'should generate a password_seed when password is added' do
      expect(@user.password_seed).not_to be nil
    end
  end

  context 'authentication' do
    before do
      @email = Faker::Internet.email
      @password = Faker::Internet.password

      FactoryBot.create(
        :user, 
        email: @email, 
        password: @password, 
        password_confirmation: @password
      )
    end


    it 'should authenticate user given correct credentials' do
      expect{
        User.authenticate(email: @email, password: @password)
      }.not_to raise_exception
    end

    it 'should reject authenticating the user given wrong credentials' do
      expect{
        User.authenticate(
          email: Faker::Internet.email, 
          password: Faker::Internet.password
        )
      }.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end
