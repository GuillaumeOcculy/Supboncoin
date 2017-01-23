class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
      set_current_user(user)
      flash[:success] = "#{user.email} is logged in !"

      user.is_admin ? redirect_to(admin_user_path(user)) : redirect_to(root_path)
    else
      flash[:danger] = "Bad credentials"
      render :new
    end
  end

  def destroy
    cookies.delete :user_id
    redirect_to root_path
  end
end
