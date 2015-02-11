class AddMiscFlagsToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :misc_flags, :integer
  end
end
