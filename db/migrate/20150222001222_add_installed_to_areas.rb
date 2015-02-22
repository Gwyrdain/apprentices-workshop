class AddInstalledToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :installed, :date
  end
end
