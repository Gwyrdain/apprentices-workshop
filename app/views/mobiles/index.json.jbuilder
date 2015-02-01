json.array!(@mobiles) do |mobile|
  json.extract! mobile, :id, :vnum, :keywords, :sdesc, :ldesc, :look_desc, :act_flags, :affect_flags, :alignment, :level, :sex, :langs_known, :lang_spoken, :area_id
  json.url mobile_url(mobile, format: :json)
end
