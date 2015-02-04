json.array!(@triggers) do |trigger|
  json.extract! trigger, :id, :trigger_type, :name, :extended_value_1, :extended_value_2, :extended_value_3, :extended_value_4, :extended_value_5, :exit_id
  json.url trigger_url(trigger, format: :json)
end
