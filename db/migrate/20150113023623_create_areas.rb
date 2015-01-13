class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.string :author
      t.string :difficulty

      t.timestamps
    end
  end
end
