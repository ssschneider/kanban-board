# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    title { "Task Title" }
    description { "Task description" }
    association :user  # Relationship com o usuário
  end
end
