class RenameFinishColumnToTripStatements < ActiveRecord::Migration[5.2]
  def change
    rename_column :trip_statements, :finish, :finish_at
  end
end
