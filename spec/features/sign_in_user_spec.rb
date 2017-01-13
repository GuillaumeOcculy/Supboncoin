require 'rails_helper'

feature 'Signing in' do
  scenario "User signed in" do
    user = create(:user)

    sign_in(user)

    expect(page).to have_text("#{user.email} is logged in !")

    expect(page).to_not have_text("Admin::Users#Show")
    expect(page).to_not have_link("Sign in")
    expect(page).to_not have_link("Sign up")
    expect(page).to have_link("Log out")
  end


  scenario "Admin signed in" do
    admin = create(:admin)

    sign_in(admin)

    expect(page).to have_text("#{admin.email} is logged in !")
    expect(page).to have_text("Admin::Users#Show")
    expect(page).to_not have_link("Sign in")
  end

end
