class TripStatement < ApplicationRecord
  belongs_to :user
  has_many :expences, dependent: :destroy
  validates :distination, presence: true
  validates :purpose, presence: true
  validates :user_id, presence: true
end
