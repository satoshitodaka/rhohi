class TripStatement < ApplicationRecord
  belongs_to :user
  validates :distination, presence: true
  validates :purpose, presence: true
end
