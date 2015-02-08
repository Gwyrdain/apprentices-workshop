class CreateSubResets < ActiveRecord::Migration
  def change
    create_table :sub_resets do |t|
      t.string :reset_type
      t.integer :val_1
      t.integer :val_2
      t.integer :val_3
      t.integer :val_4
      t.references :reset, index: true

      t.timestamps
    end
  end
end
