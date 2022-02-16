FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "jason#{n}@potion.so" }
    password { 'password' }
  end
end
