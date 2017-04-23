FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "somebody#{n}@gmail.com" }
    provider "github"
    sequence(:uid) { |n| 1000 + n }
    role "user"
  end
end
