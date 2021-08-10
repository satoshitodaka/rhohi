FactoryBot.define do
  factory :user do
    name { 'サンプル 太朗' }
    sequence(:email) { |n| "tester#{n}@rhohi.com" }
    birthday { '1993-07-05' }
    admin { true }
    system_admin { true }
    password { 'password' }
    association :company
  end
end
