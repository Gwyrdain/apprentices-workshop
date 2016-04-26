def parse_area_header_v1(header)
  m = header.match(/\{(.*)\} (........) (.*)~\s*F ([0-9|]+)/)
  
  header_info = Hash.new
  
  header_info["version"] = 1

  if m
    header_info["author"]       = m[2].strip
    header_info["name"]         = m[3].strip
    header_info["flags"] = read_hex_flags( m[4].strip )

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
  
  header_info["author"] = '<author>' if header_info["author"].length < 1
  
  header_info["name"] = '<name>' if header_info["name"].length < 1

  return header_info
  
end

def parse_area_header_v2(header)
  header_info = Hash.new
  
  header_info["version"] = 2

  header_info["author"]       = header.match(/Author (.*)~/)[1].strip
  header_info["name"]         = header.match(/Name (.*)~/)[1].strip
  
  m = header.match(/Flags (.*) End/) # Allow flags to be undefined.
  if m
    header_info["flags_string"] = m[1].strip
  else
    header_info["flags_string"] = ''
  end

  header_info["flags"]        = parse_area_flags( header_info["flags_string"] )
  
  header_info["range_low"]   = header.match(/Lowlevel (\d.*)\n/)[1].to_i
  header_info["range_high"]  = header.match(/Highlevel (\d.*)\n/)[1].to_i
  
  m = header.match(/Description\n(.*)\n~/m) # Allow description to be undefined.
  if m
    header_info["description"]  = m[1].strip
  else
    header_info["description"]  = nil
  end
  
  m = header.match(/Installed (.*)\n/) # Allow insatlled to be undefined.
  if m
    header_info["installed"]  = m[1].strip
  else
    header_info["installed"]  = nil
  end
  
  header_info["author"] = '<author>' if header_info["author"].length < 1
  
  header_info["name"] = '<name>' if header_info["name"].length < 1

  return header_info
  
end

def parse_mobiles(mobiles_block)
  
  if mobiles_block.match(/^#[a-zA-Z]+/) # Chuck it if #OBJECTS is in here, e.g.
    return nil
  else
      
    mobiles_info = Hash.new
    i = 1
    
    mobiles = mobiles_block.split(/^#/).map(&:strip)
    
    mobiles.each do |mobile|
      m = mobile.match(/^(\d*)\n(.*)~\n(.*)~\n(.*)\n~\n/)
      mobile_info = Hash.new
      mobile_info["vnum"]     = m[1].to_i
      mobile_info["keywords"] = m[2].strip
      mobile_info["sdesc"]    = m[3].strip
      mobile_info["ldesc"]    = m[4].strip
      
      m = mobile.match(/^~\n(.*)\n~\n([0-9|]*) ([0-9|]*) ([-\d]*) S\n(\d*).*\n8 8 (\d*)/m)
      mobile_info["look_desc"]    = m[1]
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
end

def parse_objects(objects_block)

  if objects_block.match(/^#[a-zA-Z]+/) # Chuck it if #ROOMS is in here, e.g.
    return nil
  else
      
    objects_info = Hash.new
    i = 1
    
    objects = objects_block.split(/^#/).map(&:strip)
    
    objects.each do |object|
      m = object.match(/^(\d*)\n(.*)~\n(.*)~\n(.*)~\n~\n/)
      object_info = Hash.new
      object_info["vnum"]     = m[1].to_i
      object_info["keywords"] = m[2].strip
      object_info["sdesc"]    = m[3].strip
      object_info["ldesc"]    = m[4].strip
      
      m = object.match(/^(\d*) ([0-9|]*) ([0-9|]*)\n(\d*) ([0-9|]*) (\d*) (\d*)\n(\d*) (\d*) 0/)
      object_info["object_type"] = m[1].to_i
      object_info["extra_flags"] = read_flags( m[2].strip )
      object_info["wear_flags"]  = read_flags( m[3].strip )
      object_info["v0"]          = m[4].to_i
      object_info["v1"]          = read_flags( m[5].strip )
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
      extra_desc["description"] = m[2]

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

def read_hex_flags( flags )
  
  if flags.match(/|/)

    total = 0
    number_list = flags.split("|").map(&:strip)
    number_list.each do |number|
      total = total + number.to_i(16)
    end
    
    return total
  else
    return flags.to_i(16)
  end

end

def parse_rooms(rooms_block)
  
  if rooms_block.match(/^#[a-zA-Z]+/) # Chuck it if #SOMETHING is in here, e.g.
    return nil
  else
      
    rooms_info = Hash.new
    i = 1
    
    rooms = rooms_block.split(/^#/).map(&:strip)
    
    rooms.each do |room|
      m = room.match(/^(\d+)\n(.*)~\n([^~]*)\n~\n(\d*) ([0-9|]*) (\d*)/)
      room_info = Hash.new
      room_info["vnum"]        = m[1].to_i
      room_info["name"]        = m[2].strip
      room_info["description"] = m[3]
      room_info["area_number"] = m[4].to_i
      room_info["room_flags"]  = read_flags( m[5].strip )
      room_info["terrain"]     = m[6].to_i
      
      if room.match(/^E$/) # any extra descriptions?
        room_info["extra_descs"] = parse_extra_descs( room.split(/^E$/).map(&:strip) )
      end
      
      if room.match(/^D\d$/) # any exits?
        room_info["exits"] = parse_exits( room.match(/^D\d\n[^°]*^S$/)[0] ) # Parse from 1st exit to end-of-room. ° is just a character not expected.
      end
      
      rooms_info[i] = room_info
      i = i + 1
    end
    
    return rooms_info
  end
end

def parse_exits(exits_block)
  exits_block.gsub!(/^D(\d)$/,'Exit: \1')
  exits_block.gsub!(/^E\n^.*~\n[^~]*~/, '') # remove extra descriptions
  exits_block.gsub!(/^S$/, '') # remove trailing S
  
  exits_list = exits_block.split(/^Exit: /).map(&:strip)
  exits_list.shift
  
  exits_info = Hash.new
  i = 1
  
  exits_list.each do |exit_data|
    exit_info = Hash.new
    
    m = exit_data.match(/^(\d)$/)
    exit_info["direction"]   = m[1].to_i
    
    m = exit_data.match(/\d\n([^~]*)~/)
    exit_info["description"] = m[1].strip
  
    m = exit_data.match(/^(.*)~\n([0-9-]*) ([0-9-]*) ([0-9-]*)$/)
    exit_info["keywords"]    = ( m[1].strip == nil ? "" : m[1].strip )
    exit_info["exittype"]    = m[2].to_i
    exit_info["key_vnum"]    = m[3].to_i
    exit_info["exit_vnum"]   = m[4].to_i
    
    if exit_data.match(/^O$/)
      m = exit_data.match(/^O\n(.*)~/)
      exit_info["name"] = m[1].strip
    else
      exit_info["name"] = ''
    end
    
    exits_info[i] = exit_info
    i = i + 1
  end
  
  return exits_info
end

def parse_helps( helps_block )
  
  if helps_block.match(/^#[a-zA-Z]+/) # Chuck it if #SOMETHING is in here, e.g.
    return nil
  else

    helps_info = Hash.new
    i = 1
    
    helps = helps_block.split(/^~$/).map(&:strip)
    helps.pop
    helps.each do |help|
      help_info = Hash.new
      
      m = help.match(/^(\d*) (.*)~\n([^~]*)/)
      help_info["min_level"] = m[1].to_i
      help_info["keywords"]  = m[2].strip
      help_info["body"]      = m[3]
      
      helps_info[i] = help_info
      i = i + 1
    end
    
    return helps_info
  end
end

def parse_strings( strings_block )
  
  if strings_block.match(/^#[a-zA-Z]+/) # Chuck it if #SOMETHING is in here, e.g.
    return nil
  else
      
    strings_info = Hash.new
    i = 1
    
    string_sets = strings_block.split(/^#/).map(&:strip)
  
    string_sets.each do |string_set|
      string_info = Hash.new
      
      m = string_set.match(/^(\d*)\n(.*)\n~\n(.*)\n~/)
      string_info["vnum"]            = m[1].to_i
      string_info["message_to_pc"]   = m[2].strip
      string_info["message_to_room"] = m[3].strip
      
      strings_info[i] = string_info
      i = i + 1
    end
    
    return strings_info
  end
end

def parse_resets (resets_block)
  
  if resets_block.match(/^#[a-zA-Z]+/) # Chuck it if #SOMETHING is in here, e.g.
    return nil
  else
    
    resets_info = Hash.new
    i = 1
    
    resets_block.gsub!(/^\*.*\n/,'')
    resets = resets_block.split(/\n/).map(&:strip)
    
    resets.each do |reset|
      reset_info = Hash.new
  
      m = reset.match(/(\w) (\d*) (\d*) (\d*)/)
      if m
        reset_info["reset_type"]  = m[1].strip
        reset_info["val_1"]       = m[2].to_i
        reset_info["val_2"]       = m[3].to_i
        reset_info["val_3"]       = m[4].to_i
      end
      
      m = reset.match(/\w \d* \d* \d* (\d*)/)
      if m
        reset_info["val_4"]       = m[1].to_i
      end
      
      resets_info[i] = reset_info
      i = i + 1  
    end
    
    return resets_info
  end
end

def parse_shops (shops_block)
  
  if shops_block.match(/^#[a-zA-Z]+/) # Chuck it if #SOMETHING is in here, e.g.
    return nil
  else
      
    shops_info = Hash.new
    i = 1
    
    shops_block.gsub!(/^\*.*\n/,'') # remove any commented out lines
    shops = shops_block.split(/\n/).map(&:strip)
    
    shops.each do |shop|
      shop_info = Hash.new
  
      m = shop.match(/^(\d*)\s*(\d*)\s*(\d*)\s*(\d*)\s*(\d*)\s*(\d*)\s*\d*\s*\d*\s*(\d*)\s*(\d*)\s*([0-9-]*)/)
      if m
        shop_info["mobile_vnum"] = m[1].to_i
        shop_info["buy_type_1"]  = m[2].to_i
        shop_info["buy_type_2"]  = m[3].to_i
        shop_info["buy_type_3"]  = m[4].to_i
        shop_info["buy_type_4"]  = m[5].to_i
        shop_info["buy_type_5"]  = m[6].to_i
        shop_info["open_hour"]   = m[7].to_i
        shop_info["close_hour"]  = m[8].to_i
        shop_info["race"]        = m[9].to_i
      end
  
      shops_info[i] = shop_info
      i = i + 1  
    end
    
    return shops_info
  end
end

def parse_specials (specials_block)
  
  if specials_block.match(/^#[a-zA-Z]+/) # Chuck it if #SOMETHING is in here, e.g.
    return nil
  else
      
    specials_info = Hash.new
    i = 1
    
    specials_block.gsub!(/^\*.*\n/,'')
    specials = specials_block.split(/\n/).map(&:strip)
    
    specials.each do |special|
      special_info = Hash.new
  
      m = special.match(/^(\w) (\d*) (\w*)/)
      if m
        special_info["type"] = m[1].strip
        special_info["vnum"] = m[2].to_i
        special_info["name"] = m[3].strip
      end
      
      m = special.match(/^\w \d* \w* ([0-9-]*) ([0-9-]*) ([0-9-]*) ([0-9-]*) ([0-9-]*)/)
      if m
        special_info["extended_value_1"] = m[1].to_i
        special_info["extended_value_2"] = m[2].to_i
        special_info["extended_value_3"] = m[3].to_i
        special_info["extended_value_4"] = m[4].to_i
        special_info["extended_value_5"] = m[5].to_i
      end
      
      specials_info[i] = special_info
      i = i + 1  
    end
    
    return specials_info
  end
end

def parse_triggers (triggers_block)
  
  if triggers_block.match(/^#[a-zA-Z]+/) # Chuck it if #SOMETHING is in here, e.g.
    return nil
  else
      
    triggers_info = Hash.new
    i = 1
    
    triggers_block.gsub!(/^\*.*\n/,'')
    triggers = triggers_block.split(/\n/).map(&:strip)
    
    triggers.each do |trigger|
      trigger_info = Hash.new
  
      m = trigger.match(/^(\w) (\d*) (\d*) (\w*)/)
      if m
        trigger_info["type"] = m[1].strip
        trigger_info["vnum"] = m[2].to_i
        trigger_info["door"] = m[3].to_i
        trigger_info["name"] = m[4].strip
      end
      
      m = trigger.match(/^\w \d* \w* \w* ([0-9-]*) ([0-9-]*) ([0-9-]*) ([0-9-]*) ([0-9-]*)/)
      if m
        trigger_info["extended_value_1"] = m[1].to_i
        trigger_info["extended_value_2"] = m[2].to_i
        trigger_info["extended_value_3"] = m[3].to_i
        trigger_info["extended_value_4"] = m[4].to_i
        trigger_info["extended_value_5"] = m[5].to_i
      end
      
      triggers_info[i] = trigger_info
      i = i + 1  
    end
    
    return triggers_info
  end
end

def parse_area_flags( flags_string )
  $value = 0
  
  flags_list = flags_string.split(" ").map(&:strip)
  m = flags_string.match(/\d/) #Any number present?
  if m
    flags_list.each do |flag|
      $value = $value + read_hex_flags( flag )
    end
  else
    flags_list.each do |flag|
      $value = $value + area_flag_as_number( flag )
    end
  end
  return $value
end

def get_area_number(area_info)
  $room_number = 0
  if area_info["mobiles_block"]
    $room_number = area_info["mobiles_block"][1]["vnum"] / 100
  end
  if area_info["objects_block"]
    $room_number = area_info["objects_block"][1]["vnum"] / 100
  end
  if area_info["rooms_block"]
    $room_number = area_info["rooms_block"][1]["area_number"]
  end
  return $room_number
end