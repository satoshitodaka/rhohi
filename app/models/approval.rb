class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :trip_statement

  def approved?(user)
    trip_statements.approved == true
  end
end