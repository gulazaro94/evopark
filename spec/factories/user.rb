FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email.#{n}@email.com" }
    password { '123123' }
  end
end
