class AddCommentToResets < ActiveRecord::Migration
  def change
    add_column :resets, :comment, :string
  end
end
