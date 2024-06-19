# spec/system/index_spec.rb
require 'rails_helper'

RSpec.describe 'Auth', type: :feature, js: true do
  let(:user) { User.create(email: 'test@example.com', password: 'password123') }

  before :each do
    Rails.application.load_seed
    visit new_user_session_path
  end

  feature 'User authentification' do
    scenario 'displays the login page successfully' do
      expect(page).to have_content('Anmeldung')
    end

    scenario "User signs up with valid information" do
      click_link 'Sign up'
      # Fill in the form with valid information
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'password123'
      fill_in 'Password confirmation', with: 'password123'

      # Submit the form
      click_button 'Sign up'

      # Expect to see a welcome message
      expect(page).to have_content('You have signed up successfully.')
    end

    scenario "User fails to sign in with invalid credentials" do
      visit new_user_session_path

      # Fill in the form with incorrect email and password
      fill_in 'Email', with: 'wrong@example.com'
      fill_in 'Password', with: 'wrongpassword'

      # Submit the form
      click_button 'Log in'

      # Expect to see an error message
      expect(page).to have_content('Invalid Email or password.')
    end

    scenario "forgot password with valid information" do
      click_link 'Forgot your password?'

      expect(page).to have_current_path(new_user_password_path)
      expect(page).to have_content("Forgot your password?")
      # Fill in the form with valid information
      fill_in 'Email', with: 'test@example.com'
      click_button 'Send me reset password instructions'
    end
  end
end
