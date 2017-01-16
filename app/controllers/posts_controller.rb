class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :require_authenticate, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Your post is created !"
      redirect_to @post
    else
      flash.now[:danger] = "Your post is not created !"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Your post is updated !"
      redirect_to @post
    else
      flash.now[:danger] = "Your post is not updated !"
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Your post is destroyed !"
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :description, :price, :user_id, :category_id)
  end

  def require_correct_user
    if @post.user_id != current_user.id
      flash[:danger] = "This is not your post !"
      redirect_to root_path
    end
  end
end
