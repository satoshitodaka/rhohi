# Company
Company.create!(name: "日立物流ファインネクスト株式会社", address: "東京都中央区京橋")
# Company.create!(name: "株式会社日立物流", address: "東京都中央区京橋")
# Company.create!(name: "株式会社日立物流東日本", address: "茨城県日立市城南町")
# Company.create!(name: "株式会社日立物流首都圏", address: "千葉県柏市末広町")
# Company.create!(name: "日立物流ソフトウェア株式会社", address: "東京都江東区東陽")

# User
admin = User.create!(name: "Admin_User",
  email: "satoshitodaka0705@gmail.com",
  password: "password",
  company_id: 1,
  birthday: "1993-07-05",
  admin: true
)
admin.add_role :admin

# User
User.create!(name: "Normal_User",
  email: "gkjojo0507@yahoo.co.jp",
  password: "password",
  company_id: 1,
  birthday: "1993-07-05",
  admin: true
)

# 5.times do
#   name = Faker::Company.name
#   address = Gimei.address.kanji
#   Company.create!(name: name, address: address)
# end

# 各社10名ずつユーザーを作成する。
Company.all.each do |company|
  10.times do
    company.users.create!(
      name: Gimei.kanji,
      email: Faker::Internet.email,
      password: "password",
      birthday: Faker::Date.between(from: '1973-01-01', to: '2003-12-31'),
      admin: false,
      system_admin: false
    )
  end
end

# 各ユーザーに1件ずつ提出済・承認済の申請情報を作成
User.all.each do |user|
  user.trip_statements.create!(
    distination: Gimei.address.kanji,
    purpose: Faker::Lorem.sentence(word_count: 3),
    start_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now),
    finish_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now),
    work_done_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now - 1),
    applied: true,
    approved: true
  )
end

# 各ユーザーに1件ずつ提出済・未承認の申請情報を作成
User.all.each do |user|
  user.trip_statements.create!(
    distination: Gimei.address.kanji,
    purpose: Faker::Lorem.sentence(word_count: 3),
    start_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now),
    finish_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now),
    work_done_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now - 1),
    applied: true,
    approved: false
  )
end

# 各ユーザーに1件ずつ未提出・未承認の申請情報を作成
User.all.each do |user|
  user.trip_statements.create!(
    distination: Gimei.address.kanji,
    purpose: Faker::Lorem.sentence(word_count: 3),
    start_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now),
    finish_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now),
    work_done_at: Faker::Time.between(from: Time.zone.now - 30, to: Time.zone.now - 1),
    applied: false,
    approved: false
  )
end

# 各申請に旅費手当情報を作成する。
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

# 承認した申請情報を作成する。
i = 1
12.times do |n|
  # i ||= 1
  # approval = Faker::Boolean.boolean
  Approval.create!(
    approval: true,
    user_id: 1,
    trip_statement_id: i
  )
  i += 1
end

# # 否認した承認情報を作成する。
# i = 13
# 12.times do |n|
#   Approval.create!(
#     approval: false,
#     user_id: 1,
#     trip_statement_id: i
#   )
#   i += 1
# end