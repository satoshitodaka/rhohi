# serup
# trip_statements
distinations = ["新宿","銀座","渋谷","品川","立川","町田","大宮","浦和","横浜","川崎"]
purposes = ["会議","事前ミーティング","採用面接","工場見学","取引先挨拶"]

# expenses
transportations = ["JR","地下鉄","タクシー","バス"]
bording_samples = ["新宿","有楽町","渋谷","立川","町田","大宮","浦和","横浜","川崎","八重洲北口","神田","秋葉原","飯田橋","外苑前"]
get_off_samples = ["新宿","有楽町","渋谷","立川","町田","大宮","浦和","横浜","川崎","八重洲北口","神田","秋葉原","飯田橋","外苑前"]
fares = [165, 170,195,200,350,500,720,810,920]
allowances = [0,2300,3200]

# Company
Company.create!(name: "サンプル1株式会社", address: "東京都中央区京橋")
Company.create!(name: "サンプル2株式会社", address: "東京都中央区京橋")
Company.create!(name: "サンプル3株式会社", address: "茨城県日立市城南町")
Company.create!(name: "サンプル4株式会社", address: "千葉県柏市末広町")
Company.create!(name: "サンプル5株式会社", address: "東京都江東区東陽")

# User
# admin = User.create!(
#   name: "Admin_User",
#   email: "satoshitodaka0705@gmail.com",
#   password: "password",
#   company_id: 1,
#   birthday: "1993-07-05",
#   admin: true
# )
# admin.add_role :admin

# User
# User.create!(
#   name: "Normal_User",
#   email: "gkjojo0507@yahoo.co.jp",
#   password: "password",
#   company_id: 1,
#   birthday: "1993-07-05",
# )

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
    distination: distinations.sample,
    purpose: purposes.sample,
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
    distination: distinations.sample,
    purpose: purposes.sample,
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
    distination: distinations.sample,
    purpose: purposes.sample,
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
    transportation: transportations.sample,
    bording: bording_samples.sample,
    get_off: get_off_samples.sample,
    fare: fares.sample,
    allowance: allowances.sample
  )
end

# # 承認した申請情報を作成する。
# i = 1
# 12.times do |n|
#   # i ||= 1
#   # approval = Faker::Boolean.boolean
#   Approval.create!(
#     approval: true,
#     user_id: 1,
#     trip_statement_id: i
#   )
#   i += 1
# end

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