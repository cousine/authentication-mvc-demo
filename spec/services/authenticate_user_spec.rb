require 'rails_helper'
require 'faker'

RSpec.describe AuthenticateUser, type: :model do
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
      authentication_service = AuthenticateUser.new(@email, @password)
      expect{
        authentication_service.perform
      }.not_to raise_exception
    end

    it 'should reject authenticating the user given wrong credentials' do
      authentication_service = AuthenticateUser.new(Faker::Internet.email, Faker::Internet.password)
      expect{
        authentication_service.perform
      }.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end
