class CreateTripStatements < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_statements do |t|
      t.string :distination
      t.string :purpose
      t.datetime :start
      t.datetime :finish
      t.datetime :work_done
      t.boolean :applied, defalut: false, null: false
      t.datetime :applied_at, default: nil
      t.boolean :approved, defalut: false, null: false
      t.datetime :approved_at, default: nil
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
