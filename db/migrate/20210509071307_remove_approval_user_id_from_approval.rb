class RemoveApprovalUserIdFromApproval < ActiveRecord::Migration[5.2]
  def change
    remove_column :approvals, :approval_user_id, :boolean
  end
end
