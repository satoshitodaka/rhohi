class CreateExpences < ActiveRecord::Migration[5.2]
  def change
    create_table :expences do |t|
      t.date :date
      t.string :transportation
      t.string :bording
      t.string :get_off
      t.integer :fare
      t.integer :mileage
      t.integer :allowance
      t.references :trip_statement, foreign_key: true

      t.timestamps
    end
  end
end
