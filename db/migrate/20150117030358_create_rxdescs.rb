class CreateRxdescs < ActiveRecord::Migration
  def change
    create_table :rxdescs do |t|
      t.string :keywords
      t.text :description
      t.references :room, index: true

      t.timestamps
    end
  end
end
