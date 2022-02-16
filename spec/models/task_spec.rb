require 'rails_helper'

RSpec.describe 'Task Model Spec', type: :model do
  before (:each) do
    @user = create(:user)

    @category_name = 'To Do'
    @category = @user.categories.create(name: @category_name)

    @task_name = 'Write tests'
    @task_deadline = Date.today
  end

  it 'should be saved when name and deadline are provided' do
    task = @category.tasks.create(name: @task_name, deadline: @task_deadline)
    expect(task.save).to eq true
  end

  it 'should not be saved when deadline is not provided' do
    task = @category.tasks.create(name: @task_name)
    expect(task.save).to eq false
  end

  it 'should not be saved when name is not provided' do
    task = @category.tasks.create(deadline: @task_deadline)
    expect(task.save).to eq false
  end

  it 'should not be saved when name is an empty string' do
    task = @category.tasks.create(name: '', deadline: @task_deadline)
    expect(task.save).to eq false
  end

  it 'should not be saved when name is nil' do
    task = @category.tasks.create(name: nil, deadline: @task_deadline)
    expect(task.save).to eq false
  end

  it 'should not be saved when date is nil' do
    task = @category.tasks.create(name: @task_name, deadline: nil)
    expect(task.save).to eq false
  end

  it 'should hold and return name' do
    task = @category.tasks.create(name: @task_name, deadline: @task_deadline)
    expect(task.name).to eq @task_name
  end

  it 'should hold and return deadline' do
    task = @category.tasks.create(name: @task_name, deadline: @task_deadline)
    expect(task.deadline).to eq @task_deadline
  end
end
