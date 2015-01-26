json.array!(@applies) do |apply|
  json.extract! apply, :id, :apply_type, :magnitude, :obj_id
  json.url apply_url(apply, format: :json)
end
