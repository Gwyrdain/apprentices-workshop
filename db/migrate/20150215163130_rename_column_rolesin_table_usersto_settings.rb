class RenameColumnRolesinTableUserstoSettings < ActiveRecord::Migration
  def change
    rename_column :users, :roles, :settings
  end
end
