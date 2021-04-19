class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :birthday, :date
    add_column :users, :approver, :boolean, default: false, null: false
    add_column :users, :system_admin, :boolean, default: false, null: false
  end
end
