class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_current_user(user)
    session[:user_id] = user.id
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

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
end
