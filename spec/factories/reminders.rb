FactoryBot.define do
  factory :reminder do
    association(:user)
    sequence(:title) { |n| "Title #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    month_day { 1 }
    time { 3.hours }
    timezone { "Europe/Dublin" }
  end
end
