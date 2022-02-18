require 'rails_helper'

RSpec.describe 'Category Model Spec', type: :model do
  before :each do
    @user = create(:user)
    @user_two = create(:user)

    @category_name = 'To Do'
  end

  it 'should be saved when name is provided' do
    category = @user.categories.build(name: @category_name)
    expect(category.save).to eq true
  end

  it 'should not be saved when name is not provided' do
    category = @user.categories.build
    expect(category.save).to eq false
  end

  it 'should not be saved when name is an empty string' do
    category = @user.categories.build(name: '')
    expect(category.save).to eq false
  end

  it 'should not be saved when name is nil' do
    category = @user.categories.build(name: nil)
    expect(category.save).to eq false
  end

  it 'should not be saved when name already exists under same user' do
    category = @user.categories.create(name: @category_name)
    category_two = @user.categories.build(name: @category_name)
    expect(category_two.save).to eq false
  end

  it 'should be saved when name already exists under a different user' do
    category = @user.categories.create(name: @category_name)
    category_two = @user_two.categories.build(name: @category_name)
    expect(category_two.save).to eq true
  end

  it 'should hold and return name' do
    category = @user.categories.create(name: @category_name)
    expect(category.name).to eq @category_name
  end
end
