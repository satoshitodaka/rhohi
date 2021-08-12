FactoryBot.define do
  factory :approval do
    approval { true }
    association :user
    association :trip_statement
    association :company
  end
end
