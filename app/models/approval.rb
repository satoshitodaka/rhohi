class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :trip_statement#,foreign_key: "approval_id"
  validates :trip_statement_id, presence: true
  validates :user_id, presence: true
  # validates :approval, presence: true

  # after_create :add_approval_for_trip_statement

  # private

  # def add_approval_for_trip_statement
  #   self.trip_statement.update(approved: true, approved_at: Time.zone.now)
  # end
end
