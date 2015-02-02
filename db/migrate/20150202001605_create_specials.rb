class CreateSpecials < ActiveRecord::Migration
  def change
    create_table :specials do |t|
      t.string :special_type
      t.string :name
      t.integer :extended_value_1
      t.integer :extended_value_2
      t.integer :extended_value_3
      t.integer :extended_value_4
      t.integer :extended_value_5
      t.references :mobile, index: true

      t.timestamps
    end
  end
end
