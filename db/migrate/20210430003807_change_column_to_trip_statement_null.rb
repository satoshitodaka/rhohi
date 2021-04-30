class ChangeColumnToTripStatementNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :trip_statements, :approved, true
    change_column_null :trip_statements, :applied, true

  end
end
