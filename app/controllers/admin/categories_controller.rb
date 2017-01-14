class Admin::CategoriesController < Admin::AdminController
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created !"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = "Category not created !"
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category updated !"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = "Category not updated !"
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end


  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
