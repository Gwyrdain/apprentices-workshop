class AddColumnsToTableAreasDefaultTerrainAndDefaultRoomFlags < ActiveRecord::Migration
  def change
    add_column :areas, :default_terrain, :integer
    add_column :areas, :default_room_flags, :integer
  end
end
