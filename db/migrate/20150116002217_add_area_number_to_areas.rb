class AddAreaNumberToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :area_number, :integer
  end
end
