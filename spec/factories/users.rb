FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "MyString" }
    password_confirmation { "MyString" }
  end
end
