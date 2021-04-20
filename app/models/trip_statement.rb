class TripStatement < ApplicationRecord
  belongs_to :user
  validates :distination, presence: true
  validates :purpose, presence: true
  validates :user_id, presence: true
end
