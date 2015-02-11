class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :user_id
      t.references :area, index: true

      t.timestamps
    end
  end
end
