json.array!(@rxdescs) do |rxdesc|
  json.extract! rxdesc, :id, :keywords, :description, :room_id
  json.url rxdesc_url(rxdesc, format: :json)
end
