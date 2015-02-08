json.array!(@sub_resets) do |sub_reset|
  json.extract! sub_reset, :id, :reset_type, :val_1, :val_2, :val_3, :val_4, :reset_id
  json.url sub_reset_url(sub_reset, format: :json)
end
