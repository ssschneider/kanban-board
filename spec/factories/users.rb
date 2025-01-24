# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "Jane Doe" }
    email { "user@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
