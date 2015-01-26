json.array!(@oxdescs) do |oxdesc|
  json.extract! oxdesc, :id, :keywords, :description, :obj_id
  json.url oxdesc_url(oxdesc, format: :json)
end
