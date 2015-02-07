json.array!(@resets) do |reset|
  json.extract! reset, :id, :reset_type, :val_1, :val_2, :val_3, :val_4, :area_id
  json.url reset_url(reset, format: :json)
end
