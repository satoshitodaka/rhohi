class Expence < ApplicationRecord
  belongs_to :trip_statement
  validates :date, presence: true
  validates :transportation, presence: true
  validates :bording, presence: true
  validates :get_off, presence: true
end
