class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[new create show destroy]
  before_action :set_task, only: %i[show destroy]

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

  def show; end

  def destroy
    @task.destroy

    redirect_to categories_path, notice: 'Deleted task'
  end

  private

  def task_params
    params.require(:task).permit(:name, :details, :deadline)
  end

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end
end
