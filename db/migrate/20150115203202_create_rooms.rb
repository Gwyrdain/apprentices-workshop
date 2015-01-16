class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :vnum
      t.string :name
      t.text :description
      t.integer :room_flags
      t.integer :terrain
      t.references :area, index: true

      t.timestamps
    end
  end
end
