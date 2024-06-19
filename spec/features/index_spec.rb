require 'rails_helper'

RSpec.describe 'Dashboard', type: :feature, js: true do
  let!(:customer) { User.create!(email: 'customer@example.com', password: 'password123', password_confirmation: 'password123', role: 'customer') }
  let!(:supervisor) { User.create!(email: 'supervisor@example.com', password: 'password123', password_confirmation: 'password123', role: 'supervisor') }

  before :each do
    Rails.application.load_seed
  end

  feature 'Customer Dashboard' do

    before :each do
      login_as(customer, scope: :user)
      visit dashboard_path
    end

    scenario 'redirects to dashboard after login' do
      expect(page).to have_current_path(root_path)
    end

    scenario 'does not have supervisor button in navbar for customer' do
      within('nav') do
        expect(page).not_to have_link('Admin')
      end
    end

  end

  feature 'Supervisor Dashboard' do
    before :each do
      login_as(supervisor, scope: :user)
      visit dashboard_path
    end

    scenario 'redirects to dashboard after login' do
      expect(page).to have_current_path(dashboard_path)
    end

    scenario 'have Admin link in navbar for supervisor' do
      within('nav') do
        expect(page).to have_link('Admin', href: supervisor_orders_path)
      end
    end
  end


  feature 'to order Product' do
    before :each do
      login_as(customer, scope: :user)
      visit dashboard_path
    end

    scenario 'allows user to order a product' do
      expect(page).to have_content('Produktübersicht')

      order_btn = find('a', text: 'Bestellen')
      order_btn.click

      expect(page).to have_content('Menge auswählen')
      fill_in 'order_amount', with: '2'
      click_button 'Save'
      # expect(page).not_to have_content("Menge auswählen")
      expect(page).to have_current_path(root_path)
    end

    scenario 'back to dashboard' do
      expect(page).to have_content('Produktübersicht')

      order_btn = find('a', text: 'Bestellen')
      order_btn.click

      expect(page).to have_content('Menge auswählen')
      back_btn = find('a', text: 'Back')
      back_btn.click
      expect(page).not_to have_content("Menge auswählen")
      expect(page).to have_current_path(root_path)
    end
  end
end
