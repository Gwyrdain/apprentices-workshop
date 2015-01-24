 class CreateObjs < ActiveRecord::Migration
  def change
    create_table :objs do |t|
      t.references :area, index: true
      t.integer :vnum
      t.string :keywords
      t.string :sdesc
      t.string :ldesc
      t.integer :type
      t.integer :v0
      t.integer :v1
      t.integer :v2
      t.integer :v3
      t.integer :extra_flags
      t.integer :wear_flags
      t.integer :weight
      t.integer :cost
      t.integer :misc_flags

      t.timestamps
    end
  end
end
