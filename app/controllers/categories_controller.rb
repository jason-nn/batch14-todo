class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :update_show_all
  before_action :set_category, only: %i[edit update destroy]
  before_action :set_categories, only: %i[index today]

  def index
    $show_all = true
    update_show_all
  end

  def today
    $show_all = false
    update_show_all
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      if @show_all
        redirect_to categories_path, notice: 'Created new category'
      else
        redirect_to today_path, notice: 'Created new category'
      end
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      if @show_all
        redirect_to categories_path, notice: 'Updated category'
      else
        redirect_to today_path, notice: 'Updated category'
      end
    else
      render :edit
    end
  end

  def destroy
    @category.destroy

    if @show_all
      redirect_to categories_path, notice: 'Deleted category'
    else
      redirect_to today_path, notice: 'Deleted category'
    end
  end

  private

  def update_show_all
    @show_all = $show_all
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def set_categories
    @categories = current_user.categories.order(:id)
  end
end
