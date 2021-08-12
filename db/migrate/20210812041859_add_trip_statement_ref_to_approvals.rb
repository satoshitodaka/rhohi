class AddTripStatementRefToApprovals < ActiveRecord::Migration[5.2]
  def change
    add_reference :approvals, :trip_statement, foreign_key: true
  end
end
