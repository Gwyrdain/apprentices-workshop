class AddUpdateInfoToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :last_updated_at, :datetime
    add_column :areas, :last_updated_by, :integer
  end
end
