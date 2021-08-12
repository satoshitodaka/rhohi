class ChangeColumunsAddNotnullOnTripStatements < ActiveRecord::Migration[5.2]
  def change
    change_column_null :trip_statements, :distination, false
    change_column_null :trip_statements, :purpose, false
    change_column_null :trip_statements, :start_at, false
    change_column_null :trip_statements, :finish_at, false
    change_column_null :trip_statements, :work_done_at, false
  end
end
