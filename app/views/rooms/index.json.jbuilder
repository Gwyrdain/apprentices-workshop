json.array!(@rooms) do |room|
  json.extract! room, :id, :vnum, :name, :description, :room_flags, :terrain, :area_id
  json.url room_url(room, format: :json)
end
