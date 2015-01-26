class RenameColumnMagnitudeInTableAppliesToAmount < ActiveRecord::Migration
  def change
    rename_column :applies, :magnitude, :amount
  end
end
