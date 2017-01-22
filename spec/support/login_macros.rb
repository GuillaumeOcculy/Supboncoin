module LoginMacros

  def set_user_session(user)
    cookies.signed[:user_id] = user.id
  end

  def sign_in(user)
    visit root_path
    click_link 'Sign in'

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button 'Sign in'
  end
end
