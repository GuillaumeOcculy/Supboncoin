module CurrentUser
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def set_current_user(user)
    cookies.permanent.signed[:user_id] = user.id
  end

  def current_user
    @user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def require_authenticate
    if !cookies.signed[:user_id]
      redirect_to sign_in_path
      flash[:danger] = "You need signed in"
    end
  end

  def no_require_authenticate
    if cookies.signed[:user_id]
      redirect_to root_path
      flash[:danger] = "You are already signed in"
    end
  end

  def require_admin
    if !current_user.is_admin
      redirect_to root_path
      flash[:danger] = "You need to be an admin"
    end
  end
end
