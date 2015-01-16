class AddFlagsToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :flags, :integer
  end
end
