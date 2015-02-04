json.array!(@room_specials) do |room_special|
  json.extract! room_special, :id, :room_special_type, :name, :extended_value_1, :extended_value_2, :extended_value_3, :extended_value_4, :extended_value_5, :room_id
  json.url room_special_url(room_special, format: :json)
end
