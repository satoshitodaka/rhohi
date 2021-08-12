class RemoveTripStatementIdFromApprovals < ActiveRecord::Migration[5.2]
  def change
    remove_column :approvals, :trip_statement_id, :integer
  end
end
