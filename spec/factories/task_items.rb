FactoryBot.define do
  factory :task_item do
    description { Faker::Lorem.sentence }
  end
end
