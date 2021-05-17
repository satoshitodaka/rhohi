class RenameWorkDoneColumnToTripStatements < ActiveRecord::Migration[5.2]
  def change
    rename_column :trip_statements, :work_done, :work_done_at
  end
end
