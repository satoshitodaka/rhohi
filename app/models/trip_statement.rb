class TripStatement < ApplicationRecord
  # 関連付
  belongs_to :user
  has_many :expences, dependent: :destroy
  has_many :approvals

  # バリデーション
  validates :distination, presence: true
  validates :purpose, presence: true
  validates :start_at, presence: true
  validates :finish_at, presence: true
  validates :work_done_at, presence: true
  validates :user_id, presence: true
end
