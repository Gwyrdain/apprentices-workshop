class AddCommentToResets < ActiveRecord::Migration
  def change
    add_column :resets, :reset_comment, :string
  end
end
