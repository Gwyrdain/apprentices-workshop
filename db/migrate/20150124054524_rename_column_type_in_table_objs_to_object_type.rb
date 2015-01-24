class RenameColumnTypeInTableObjsToObjectType < ActiveRecord::Migration
  def change
    rename_column :objs, :type, :object_type
  end
end
