# Company
Company.create!(name: "日立物流ファインネクスト株式会社", address: "東京都中央区京橋")

# User
User.create!(name: "戸高 仁",
  email: "gkjojo0507@yahoo.co.jp",
  password: "password",
  company_id: 1
)

5.times do
  name = Faker::Company.name
  address = Gimei.address.kanji
  Company.create!(name: name, address: address)
end

Company.all.each do |company|
  company.users.create!(
    name: Gimei.kanji,
    email: Faker::Internet.email,
    password: "password",
    admin: false,
    system_admin: false
  )
end

User.all.each do |user|
  user.trip_statements.create!(
    start_at: Time.zone.now,
    finish_at: Time.zone.now,
    work_done_at: Time.zone.now,
    distination: Gimei.address.kanji,
    purpose: Faker::Lorem.sentence(word_count: 3),
    applied: true,
    approved: false
  )
end

User.all.each do |user|
  user.trip_statements.create!(
    start_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now),
    finish_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now),
    work_done_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now),
    distination: Gimei.address.kanji,
    purpose: Faker::Lorem.sentence(word_count: 3),
    applied: false,
    approved: false
  )
end

TripStatement.all.each do |trip_statement|
  trip_statement.expences.create!(
    date: Faker::Date.between(from: 30.days.ago, to: Date.today),
    transportation: Faker::Lorem.sentence(word_count: 1),
    bording: Faker::Lorem.sentence(word_count: 1),
    get_off: Faker::Lorem.sentence(word_count: 1),
    fare: Faker::Lorem.sentence(word_count: 3),
    allowance: true
  )
end

# companies = Company.order(:created_at).take(3)
# 20.times do
#   user_name = Gimei.kanji
#   email = "example-#{n+1}@rhohi.com"
#   companies.each { |company| company.users.create!(name: user_name, email: email, password: "password") }
# end

# # TripStatement

# users = User.order(:created_at).take(15)
# 30.times do
#   distination = Gimei.address.kanji
#   purpose = Faker::Lorem.sentence(word_count: 5)
#   users.each { |user| user.trip_statements.create!(distination: distination, purpose: purpose, applied: false, approved: false) }
# end
