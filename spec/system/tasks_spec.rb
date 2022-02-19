require 'rails_helper'

RSpec.describe 'Tasks System Spec', type: :system do
  before { driven_by(:rack_test) }

  before :all do
    @user = create(:user)

    @category_name = 'To Do'
    @task_name = 'Write tests'
    @task_deadline = Date.today

    @category = @user.categories.create(name: @category_name)
    @task = @category.tasks.create(name: @task_name, deadline: @task_deadline)
  end

  before :each do
    sign_in @user
    visit categories_path
  end

  after :all do
    @user.destroy
  end

  it 'creating task' do
    click_on 'New task'
    expect(page).to have_content('New task')
    expect(page).to have_content(@category_name)

    fill_in 'Name', with: 'Run tests'
    click_on 'Create task'
    expect(page).to have_content('Run tests')
  end

  it 'reading task' do
    click_on @task_name
    expect(page).to have_content(@task_name)
    expect(page).to have_content(@category_name)
    expect(page).to have_content(
      @task_deadline.in_time_zone(8).strftime('%B %d, %Y'),
    )
  end

  it 'updating task' do
    click_on @task_name
    expect(page).to have_content(@task_name)
    expect(page).to have_content(@category_name)

    click_on '􀈊'
    expect(page).to have_content('Edit task')
    fill_in 'Name', with: 'Run tests'
    click_on 'Update task'
    expect(page).to have_content('Run tests')
  end

  it 'destroying task' do
    click_on @task_name
    expect(page).to have_content(@task_name)
    expect(page).to have_content(@category_name)

    click_on '􀈑'
    visit categories_path
    expect(page).not_to have_content(@task_name)
  end
end
