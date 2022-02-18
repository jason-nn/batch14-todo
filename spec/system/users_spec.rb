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

  after :all do
    @user.destroy
  end
end
