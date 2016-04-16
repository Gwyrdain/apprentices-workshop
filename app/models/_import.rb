def parse_area_header_v1(header)
  m = header.match(/\{(.*)\} (........) (.*)~\s*F ([0-9|]+)/)
  
  header_info = Hash.new
  
  header_info["version"] = 1
  
  if m
    header_info["author"] = m[2].strip
    header_info["name"]   = m[3].strip
    header_info["flags"]  = read_flags( m[4].strip )

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

def parse_area_header_v2(header)
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
    
    m = mobile.match(/^~\n(.*)\n~\n([0-9|]*) ([0-9|]*) ([-\d]*) S\n(\d*).*\n8 8 (\d*)/m)
    mobile_info["look_desc"]    = m[1].strip
    mobile_info["act_flags"]    = read_flags( m[2].strip )
    mobile_info["affect_flags"] = read_flags( m[3].strip )
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

def parse_objects(objects_block)
  objects_info = Hash.new
  i = 1
  
  objects = objects_block.split("#").map(&:strip)
  
  objects.each do |object|
    m = object.match(/^(\d*)\n(.*)~\n(.*)~\n(.*)\n~\n/)
    object_info = Hash.new
    object_info["vnum"]     = m[1].to_i
    object_info["keywords"] = m[2].strip
    object_info["sdesc"]    = m[3].strip
    object_info["ldesc"]    = m[4].strip
    
    m = object.match(/^(\d*) ([0-9|]*) ([0-9|]*)\n(\d*) (\d*) (\d*) (\d*)\n(\d*) (\d*) 0/)
    object_info["object_type"] = m[1].to_i
    object_info["extra_flags"] = read_flags( m[2].strip )
    object_info["wear_flags"]  = read_flags( m[3].strip )
    object_info["v0"]          = m[4].to_i
    object_info["v1"]          = m[5].to_i
    object_info["v2"]          = m[6].to_i
    object_info["v3"]          = m[7].to_i
    object_info["weight"]      = m[8].to_i
    object_info["cost"]        = m[9].to_i

    if object.match(/^E$/) # any extra descriptions?
      object_info["extra_descs"] = parse_extra_descs( object.split(/^E$/).map(&:strip) )
    end
    
    if object.match(/^A$/) # Object has any applies?
      applies_list = object.split(/^A$/).map(&:strip) # Split by A and remove front end junk.
      applies_list.shift
      
      applies = Hash.new
      
      j = 1
      
      applies_list.each do |apply_group|
        
        apply = Hash.new
        am = apply_group.match(/^(\d*) (\d*)/)
        apply["apply_type"] = am[1].to_i
        apply["amount"]     = am[2].to_i
        
        applies[j] = apply
        j = j + 1
      end
      
      object_info["applies"] = applies
    end
    
    if object.match(/^F$/)
      object_info["flammable"] = true
    end
    if object.match(/^M$/)
      object_info["metallic"] = true
    end
    if object.match(/^T$/)
      object_info["two_handed"] = true
    end
    if object.match(/^U$/)
      object_info["underwater_breath"] = true
    end
    
    objects_info[i] = object_info
    i = i + 1
  end
  
  return objects_info
end

def parse_extra_descs(extras_list)
  extras_list.shift
  extra_descs = Hash.new
  
  i = 1
  
  extras_list.each do |desc|
    m = desc.match(/^(.*)~\n(.*)\n~/m)

    if m
      extra_desc = Hash.new
      extra_desc["keywords"]    = m[1].strip
      extra_desc["description"] = m[2].strip

      extra_descs[i] = extra_desc
      i = i + 1
    end
  end  
  
  return extra_descs
  
end

def read_flags( flags )
  
  if flags.match(/|/)

    total = 0
    number_list = flags.split("|").map(&:strip)
    number_list.each do |number|
      total = total + number.to_i
    end
    
    return total
  else
    return flags.to_i
  end

end