class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :update_show_all
  before_action :set_category
  before_action :set_task, only: %i[show edit update destroy]

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.new(task_params)

    if @task.save
      if @show_all
        redirect_to categories_path, notice: 'Created new task'
      else
        redirect_to today_path, notice: 'Created new task'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to category_task_path(@task.category_id, @task.id),
                  notice: 'Updated category'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    if @show_all
      redirect_to categories_path, notice: 'Deleted task'
    else
      redirect_to today_path, notice: 'Deleted task'
    end
  end

  private

  def update_show_all
    @show_all = $show_all
  end

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
