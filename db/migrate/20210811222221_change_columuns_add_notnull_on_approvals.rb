class ChangeColumunsAddNotnullOnApprovals < ActiveRecord::Migration[5.2]
  def change
    change_column_null :approvals, :approval, false
  end
end
