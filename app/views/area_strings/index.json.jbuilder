json.array!(@area_strings) do |area_string|
  json.extract! area_string, :id, :vnum, :message_to_pc, :message_to_room, :area_id
  json.url area_string_url(area_string, format: :json)
end
