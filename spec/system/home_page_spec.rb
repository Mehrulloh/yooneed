# spec/system/home_page_spec.rb
require 'rails_helper'

RSpec.describe 'Home Page', type: :system do
  before do
    visit root_path
  end

  it 'displays welcome message' do
    visit root_path

    expect(page).to have_content('Signed in successfully.')
  end


  # it 'allows user to log in' do
  #   user = FactoryBot.create(:user, email: 'user@example.com', password: 'password')
  #
  #   visit new_user_session_path
  #
  #   fill_in 'Email', with: 'user@example.com'
  #   fill_in 'Password', with: 'password'
  #   click_button 'Log in'
  #
  #   expect(page).to have_content('Signed in successfully.')
  # end
end
