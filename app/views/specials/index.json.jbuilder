json.array!(@specials) do |special|
  json.extract! special, :id, :special_type, :name, :extended_value_1, :extended_value_2, :extended_value_3, :extended_value_4, :extended_value_5, :mobile_id
  json.url special_url(special, format: :json)
end
