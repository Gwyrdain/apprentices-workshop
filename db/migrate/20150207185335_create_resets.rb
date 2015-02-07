class CreateResets < ActiveRecord::Migration
  def change
    create_table :resets do |t|
      t.string :reset_type
      t.integer :val_1
      t.integer :val_2
      t.integer :val_3
      t.integer :val_4
      t.references :area, index: true

      t.timestamps
    end
  end
end
