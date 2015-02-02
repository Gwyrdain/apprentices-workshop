class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.integer :buy_type_1
      t.integer :buy_type_2
      t.integer :buy_type_3
      t.integer :buy_type_4
      t.integer :buy_type_5
      t.integer :open_hour
      t.integer :close_hour
      t.integer :race
      t.references :mobile, index: true

      t.timestamps
    end
  end
end
