json.array!(@applies) do |apply|
  json.extract! apply, :id, :apply_type, :amount, :obj_id
  json.url apply_url(apply, format: :json)
end
