class Expence < ApplicationRecord

  # 関連付
  belongs_to :trip_statement
  has_one :users, through: :trip_statements

  # バリデーション
  validates :date, presence: true
  validates :transportation, presence: true
  validates :bording, presence: true
  validates :get_off, presence: true
end
