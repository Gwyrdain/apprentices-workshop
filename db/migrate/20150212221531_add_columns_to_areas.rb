class AddColumnsToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :description, :text, :default => ''
    add_column :areas, :lowlevel, :integer, :default => 1
    add_column :areas, :highlevel, :integer, :default => 50
  end
end
