module CurrentUser
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end
  
  def set_current_user(user)
    session[:user_id] = user.id
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_authenticate
    if !session[:user_id]
      redirect_to sign_in_path
      flash[:danger] = "You need signed in"
    end
  end

  def no_require_authenticate
    if session[:user_id]
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
