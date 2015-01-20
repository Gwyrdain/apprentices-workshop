class RenameColumnExittoInTableExitsToExitRoomId < ActiveRecord::Migration
  def change
    rename_column :exits, :exitto, :exit_room_id
  end
end
