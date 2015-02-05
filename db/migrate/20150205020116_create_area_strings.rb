class CreateAreaStrings < ActiveRecord::Migration
  def change
    create_table :area_strings do |t|
      t.integer :vnum
      t.string :message_to_pc
      t.string :message_to_room
      t.references :area, index: true

      t.timestamps
    end
  end
end
