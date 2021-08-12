class ChangeColumunsAddNotnullOnExpence < ActiveRecord::Migration[5.2]
  def change
    change_column_null :expences, :date, false
    change_column_null :expences, :transportation, false
    change_column_null :expences, :bording, false
    change_column_null :expences, :get_off, false
    change_column_null :expences, :fare, false
  end
end
