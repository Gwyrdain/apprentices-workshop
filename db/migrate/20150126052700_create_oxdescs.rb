class CreateOxdescs < ActiveRecord::Migration
  def change
    create_table :oxdescs do |t|
      t.string :keywords
      t.text :description
      t.references :obj, index: true

      t.timestamps
    end
  end
end


