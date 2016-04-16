def parse_area_header_v1(header, user_id)
  m = header.match(/\{(.*)\} (........) (.*)~\s*F (\d+)/)
  
  header_info = Hash.new
  
  header_info["version"] = 1
  
  if m
    header_info["author"] = m[2].strip
    header_info["name"]   = m[3].strip
    header_info["flags"]  = m[4].to_i

    if m[1].match(/(\d) (\d)/)
      range = m[1].match(/(\d+) (\d+)/)
        header_info["range_low"]  = range[1].to_i
        header_info["range_high"] = range[2].to_i
    else
      if m[1].match(/ALL/)
        header_info["range_low"]   = 1
        header_info["range_high"]  = 50
      end
      if m[1].match(/HARD/)
        header_info["range_low"]   = 50
        header_info["range_high"]  = 50
      end
    end
  end

  return header_info
  
end

def parse_area_header_v2(header, user_id)
  header_info = Hash.new
  
  header_info["version"] = 2
  
  header_info["author"] = header.match(/Author (.*)~/)[1].strip
  header_info["name"]   = header.match(/Name (.*)~/)[1].strip
  header_info["flags"]  = header.match(/Flags (.*) End/)[1].strip
  
  header_info["range_low"]   = header.match(/Lowlevel (\d.*)\n/)[1].to_i
  header_info["range_high"]  = header.match(/Highlevel (\d.*)\n/)[1].to_i
  
  header_info["description"]  = header.match(/Description\n(.*)\n~/m)[1].strip
  
  if header.match(/Installed (.*)\n/)
    header_info["installed"]  = header.match(/Installed (.*)\n/)[1].strip
  else
    header_info["installed"]  = nil
  end
  
  return header_info
  
end

def parse_mobiles(mobiles_block)
  mobiles_info = Hash.new
  i = 1
  
  mobiles = mobiles_block.split("#").map(&:strip)
  
  mobiles.each do |mobile|
    m = mobile.match(/^(\d*)\n(.*)~\n(.*)~\n(.*)\n~\n/)
    mobile_info = Hash.new
    mobile_info["vnum"]     = m[1].to_i
    mobile_info["keywords"] = m[2].strip
    mobile_info["sdesc"]    = m[3].strip
    mobile_info["ldesc"]    = m[4].strip
    
    m = mobile.match(/^~\n(.*)\n~\n(\d*) (\d*) ([-\d]*) S\n(\d*).*\n8 8 (\d*)/m)
    mobile_info["look_desc"]    = m[1].strip
    mobile_info["act_flags"]    = m[2].to_i
    mobile_info["affect_flags"] = m[3].to_i
    mobile_info["alignment"]    = m[4].to_i
    mobile_info["level"]        = m[5].to_i
    mobile_info["sex"]          = m[6].to_i
    
    # add all the optionals!!! L, A, N, O
    if mobile.match(/^L\n(\d*) (\d*)/)
      languages = mobile.match(/^L\n(\d*) (\d*)/)
      mobile_info["langs_known"] = languages[1].to_i
      mobile_info["lang_spoken"] = languages[2].to_i
    end
    
    # Should we even check this since it's in the act_flags?
    if mobile.match(/^A$/)
      mobile_info["animal"] = true
    end
    
    # Should we even check this since it's in the act_flags?
    if mobile.match(/^N$/)
      mobile_info["no_wear_eq"] = true
    end
    
    if mobile.match(/^O\n(.*)~/)
      mobile_info["one_spell"] = mobile.match(/^O\n(.*)~/)[1].strip
    end
    
    mobiles_info[i] = mobile_info
    i = i + 1
  end
  
  return mobiles_info
end

