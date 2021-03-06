class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :require_authenticate, only: [:edit, :update]
  before_action :no_require_authenticate, only: [:new, :create]

  def index
    if params[:letter]
      @users = User.by_letter(params[:letter])
    else
      @users = User.order('last_name, first_name')
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      set_current_user(@user)
      flash[:success] = "Your account is created !"
      redirect_to @user
    else
      flash.now[:danger] = "Your account is not created !"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account is updated !"
      redirect_to @user
    else
      flash.now[:danger] = "Your account is not updated !"
      render :edit
    end
  end


  private
  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :phone)
  end
end
