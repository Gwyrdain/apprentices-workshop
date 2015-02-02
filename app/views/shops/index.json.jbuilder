json.array!(@shops) do |shop|
  json.extract! shop, :id, :buy_type_1, :buy_type_2, :buy_type_3, :buy_type_4, :buy_type_5, :open_hour, :close_hour, :race, :mobile_id
  json.url shop_url(shop, format: :json)
end
