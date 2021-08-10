FactoryBot.define do
  factory :trip_statement do
    distination { 'Tokyo' }
    purpose { 'Meeting' }
    start_at { Time.zone.now }
    finish_at { Time.zone.now }
    work_done_at { Time.zone.now }
    association :user
  end
end
