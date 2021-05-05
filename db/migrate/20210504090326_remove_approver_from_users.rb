class RemoveApproverFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :approver, :boolean
  end
end
