FactoryBot.define do
  factory :expence do
    date { Time.zone.now }
    transportation { 'Train' }
    bording { 'Tokyo' }
    get_off { 'Ueno' }
    association :trip_statement
  end
end
