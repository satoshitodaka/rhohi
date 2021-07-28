class Company < ApplicationRecord
  has_many :departments
  has_many :users
  validates :name, presence: true
  validates :address, presence: true
end