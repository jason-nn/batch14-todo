require 'rails_helper'

RSpec.describe 'Users System Spec', type: :system do
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
    visit root_path
  end

  after :all do
    @user.destroy
  end

  it 'existing user' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Log in'

    expect(page).to have_content('All tasks')
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content(@category_name)
    expect(page).to have_content(@task_name)
  end

  it 'new user' do
    click_on 'Sign up'
    fill_in 'Email', with: "_#{@user.email}"
    fill_in 'Password', with: "_#{@user.password}"
    fill_in 'Password confirmation', with: "_#{@user.password}"

    click_on 'Sign up'
    expect(page).to have_content('All tasks')
    expect(page).to have_content('You have signed up successfully.')
    expect(page).not_to have_content(@category_name)
    expect(page).not_to have_content(@task_name)
  end
end
