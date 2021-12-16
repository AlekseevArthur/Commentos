require 'rails_helper'

RSpec.describe 'Test device functionality', type: :feature do
  scenario 'sign in as admin', js: true do
    admin = create(:admin)
    visit '/'
    click_on 'sing in'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Log in'
    expect(page).to have_content('Welcome, admin@admin')
  end

  scenario 'sign up as user', js: true do
    visit '/'
    expect(page).to have_content('Welcome, Stranger')
    click_on 'sing in'
    click_on 'Sign up'
    fill_in 'Email', with: 'qwerty@qwerty'
    fill_in 'Password', with: 'qwerty123'
    fill_in 'user[password_confirmation]', with: 'qwerty123'
    click_on 'Sign up'
    expect(page).to have_content('Welcome, qwerty@qwerty')
  end
end
