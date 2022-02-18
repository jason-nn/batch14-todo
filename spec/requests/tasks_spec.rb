require 'rails_helper'

RSpec.describe 'Tasks Request Spec', type: :request do
  before (:each) do
    @user = create(:user)
    sign_in @user

    @category = @user.categories.create(name: 'To Do')
    @task = @category.tasks.create(name: 'Write tests', deadline: Date.today)
  end

  it 'show' do
    get category_task_path(@task.category_id, @task)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)
  end

  it 'new' do
    get new_category_task_path(@category)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end

  it 'edit' do
    get edit_category_task_path(@task.category_id, @task)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  it 'create' do
    post category_tasks_path(@category),
         params: {
           task: {
             name: 'Run tests',
             deadline: Date.today,
           },
         }
    expect(response).to have_http_status(302)
  end

  it 'update' do
    patch category_task_path(@task.category_id, @task),
          params: {
            task: {
              name: 'Run tests',
            },
          }
    expect(response).to have_http_status(302)
  end

  it 'destroy' do
    delete category_task_path(@task.category_id, @task)
    expect(response).to have_http_status(302)
  end
end
