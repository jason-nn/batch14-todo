class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = current_user.categories.order(:id)
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Created new category'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Updated category'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def today
    @categories = current_user.categories.order(:id)
  end

  def destroy
    @category.destroy

    redirect_to categories_path, status: :see_other, notice: 'Deleted category'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
