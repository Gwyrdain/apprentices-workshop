class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roles, :integer
  end
end
