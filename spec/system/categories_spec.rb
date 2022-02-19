require 'rails_helper'

RSpec.describe 'Categories System Spec', type: :system do
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

  it 'creating category' do
    click_on '􀅼'
    expect(page).to have_content('New category')
    fill_in 'Name', with: 'Doing'
    click_on 'Create category'
    expect(page).to have_content('Doing')
  end

  it 'updating category' do
    click_on '􀈊'
    expect(page).to have_content('Edit category')
    fill_in 'Name', with: 'Doing'
    click_on 'Update category'
    expect(page).to have_content('Doing')
  end

  it 'destroying category', js: true do
    click_on '􀈑'
    visit categories_path
    expect(page).not_to have_content(@category_name)
  end
end
