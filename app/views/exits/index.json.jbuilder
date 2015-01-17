json.array!(@exits) do |exit|
  json.extract! exit, :id, :direction, :description, :keywords, :exittype, :keyvnum, :exitto, :name, :room_id
  json.url exit_url(exit, format: :json)
end
