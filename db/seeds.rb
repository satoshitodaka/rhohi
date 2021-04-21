# Company
Company.create!(name: "日立物流ファインネクスト株式会社", address: "東京都中央区京橋")

# 5.times do |n|
#   name = Faker::Company.name
#   address = Gimei.address.kanji
#   Company.create!(name: name, address: address)
# end

# User
User.create!(name: "戸高 仁",
  email: "satoshitodaka@rhohi.com",
  password: "password",
  compnay_id: 1
)

# users = 
# 10.times do |n|
#   user_name = Gimei.kanji
#   email = "example-#{n+1}@rhohi.com"
#   User.create!(name: user_name, email: email, password: "password")

# TripStatement

# TripStatement.create!(distination: "tokyo", purpose: "dinner", applied: false, approved: false)