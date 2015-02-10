class AddResetToExits < ActiveRecord::Migration
  def change
    add_column :exits, :reset, :integer
  end
end
