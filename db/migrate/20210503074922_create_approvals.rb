class CreateApprovals < ActiveRecord::Migration[5.2]
  def change
    create_table :approvals do |t|
      t.integer :trip_statement_id
      t.integer :approval_user_id
      t.boolean :approval
      t.string :comment

      t.timestamps
    end
  end
end
