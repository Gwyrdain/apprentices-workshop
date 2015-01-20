json.array!(@exits) do |exit|
  json.extract! exit, :id, :direction, :description, :keywords, :exittype, :keyvnum, :exit_room_id, :name, :room_id
  json.url exit_url(exit, format: :json)
end
