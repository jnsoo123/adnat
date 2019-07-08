FactoryBot.define do
  factory :user do
    name             { 'Someone' }
    sequence(:email) { |n| "test_#{n}@user.com" }
    password         { 'password' }
  end
end
