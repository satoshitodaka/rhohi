class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :trip_statement
  validates :trip_statement_id, presence: true
  validates :user_id, presence: true
  # validates :approval, presence: true
end
