class CreateMobiles < ActiveRecord::Migration
  def change
    create_table :mobiles do |t|
      t.integer :vnum
      t.string :keywords
      t.string :sdesc
      t.string :ldesc
      t.text :look_desc
      t.integer :act_flags
      t.integer :affect_flags
      t.integer :alignment
      t.integer :level
      t.integer :sex
      t.integer :langs_known
      t.integer :lang_spoken
      t.references :area, index: true

      t.timestamps
    end
  end
end
