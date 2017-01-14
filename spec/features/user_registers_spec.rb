require 'rails_helper'

feature 'User registers' do
  scenario 'With valid details' do
    visit root_path

    click_link "Sign up"

    fill_in :user_first_name, with: 'guillaume'
    fill_in :user_last_name, with: 'west'
    fill_in :user_email, with: 'guillaume@west.com'
    fill_in :user_password, with: 'password'
    click_button 'Sign up'

    expect(page).to have_text("Your account is created !")
  end

  scenario 'With invalid details' do
    visit root_path

    click_link "Sign up"

    fill_in :user_first_name, with: 'guillaume'
    fill_in :user_last_name, with: 'west'
    fill_in :user_email, with: ''
    fill_in :user_password, with: 'password'
    click_button 'Sign up'

    expect(page).to have_text("Your account is not created !")
  end
end
