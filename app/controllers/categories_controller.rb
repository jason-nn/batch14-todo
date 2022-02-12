class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_show_all
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = current_user.categories.order(:id)

    $show_all = true
    set_show_all
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

  def destroy
    @category.destroy

    redirect_to categories_path, status: :see_other, notice: 'Deleted category'
  end

  def today
    @categories = current_user.categories.order(:id)

    $show_all = false
    set_show_all
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def set_show_all
    @show_all = $show_all
  end
end
