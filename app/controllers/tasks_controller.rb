class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[new]

  def new
    @task = @category.tasks.new
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end
end
