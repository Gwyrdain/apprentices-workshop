json.array!(@objs) do |obj|
  json.extract! obj, :id, :area_id, :vnum, :keywords, :sdesc, :ldesc, :object_type, :v0, :v1, :v2, :v3, :extra_flags, :wear_flags, :weight, :cost, :misc_flags
  json.url obj_url(obj, format: :json)
end
