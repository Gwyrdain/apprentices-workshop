class AddRevisionToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :revision, :integer, :default => 0
  end
end
