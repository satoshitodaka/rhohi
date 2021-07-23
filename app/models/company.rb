class Company < ApplicationRecord
  # 関連付
  has_many :departments
  has_many :users

  # バリデーション
  validates :name, presence: true
  validates :address, presence: true
end