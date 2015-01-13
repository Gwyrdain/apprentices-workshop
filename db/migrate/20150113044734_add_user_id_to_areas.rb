class AddUserIdToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :user_id, :integer
    add_index :areas, :user_id
  end
end
