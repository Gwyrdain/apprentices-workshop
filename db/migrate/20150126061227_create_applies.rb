class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.integer :apply_type
      t.integer :magnitude
      t.references :obj, index: true

      t.timestamps
    end
  end
end


