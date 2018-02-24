require 'rails_helper'

RSpec.feature "Authentications", type: :feature do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'should redirect to the root url given correct credentials' do
    visit new_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    click_button "Login"

    expect(page).to have_text "Users"
  end
end
