class CreateExits < ActiveRecord::Migration
  def change
    create_table :exits do |t|
      t.integer :direction
      t.text :description
      t.string :keywords
      t.integer :exittype
      t.integer :keyvnum
      t.integer :exitto
      t.string :name
      t.references :room, index: true

      t.timestamps
    end
  end
end
