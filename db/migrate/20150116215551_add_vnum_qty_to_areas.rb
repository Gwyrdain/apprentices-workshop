class AddVnumQtyToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :vnum_qty, :integer
  end
end
