class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[new create]

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.new(task_params)

    if @task.save
      redirect_to categories_path, notice: 'Created new task'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :details, :deadline)
  end

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end
end
