class RenameStartColumnToTripStatements < ActiveRecord::Migration[5.2]
  def change
    rename_column :trip_statements, :start, :start_at
  end
end
