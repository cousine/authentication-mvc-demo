require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  context 'registration' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'should generate a hashed_password when password is added' do
      expect(@user.hashed_password).not_to be nil
    end

    it 'should generate a password_seed when password is added' do
      expect(@user.password_seed).not_to be nil
    end
  end
end
