class RemoveDifficultyFromAreas < ActiveRecord::Migration
  def change
    remove_column :areas, :difficulty
  end
end
