class AddUserIdToApproval < ActiveRecord::Migration[5.2]
  def change
    add_reference :approvals, :user, foreign_key: true
  end
end
