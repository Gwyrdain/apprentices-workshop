class AddSpellToMobiles < ActiveRecord::Migration
  def change
    add_column :mobiles, :spell, :string
  end
end
