require 'rails_helper'

RSpec.describe 'Categories Request Spec', type: :request do
  before :each do
    @user = create(:user)
    sign_in @user

    @category = @user.categories.create(name: 'To Do')
  end

  it 'root' do
    get root_path
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  it 'index' do
    get categories_path
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  it 'today' do
    get today_path
    expect(response).to have_http_status(200)
    expect(response).to render_template(:today)
  end

  it 'new' do
    get new_category_path
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end

  it 'edit' do
    get edit_category_path(@category)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  it 'create' do
    post categories_path, params: { category: { name: 'Doing' } }
    expect(response).to have_http_status(302)
  end

  it 'update' do
    patch category_path(@category), params: { category: { name: 'Doing' } }
    expect(response).to have_http_status(302)
  end

  it 'destroy' do
    delete category_path(@category)
    expect(response).to have_http_status(302)
  end
end
