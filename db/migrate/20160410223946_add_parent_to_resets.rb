class AddParentToResets < ActiveRecord::Migration
  def change
    add_column :resets, :parent_type, :string
    add_column :resets, :parent_id, :integer
  end
end
