class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|
      t.integer :min_level
      t.string :keywords
      t.text :body
      t.references :area, index: true

      t.timestamps
    end
  end
end
