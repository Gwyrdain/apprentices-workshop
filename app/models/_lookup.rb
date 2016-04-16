# functions to fetch Room, Object, Mobile retated strings
def obj_info(id, property, area)
  $result = nil
  if ( Obj.exists?(:id => id) && Obj.find(id).area == area )
    $this_obj = Obj.find(id)
    $result = $this_obj.formal_vnum.to_s if property == 'formal_vnum'
    $result = $this_obj.sdesc            if property == 'sdesc'
    $result = $this_obj.type_word        if property == 'type_word'
    $result = $this_obj.ldesc            if property == 'ldesc'
  else
    if property == 'formal_vnum'
      $result = id.to_s # Assume an external vnum is referenced and return such. 
    else
      $result = 'UNKNOWN' 
    end
  end
  return $result
end

def room_info(id, property)
  $result = nil
  if Room.exists?(:id => id)
    $this_room = Room.find(id)
    $result = $this_room.formal_vnum.to_s if property == 'formal_vnum'
    $result = $this_room.name             if property == 'name'
  else
    $result = 'UNKNOWN'
  end
  return $result
end

def mobile_info(id, property)
  $result = nil
  if Mobile.exists?(:id => id)
    $this_mobile = Mobile.find(id)
    $result = $this_mobile.formal_vnum.to_s if property == 'formal_vnum'
    $result = $this_mobile.sdesc            if property == 'sdesc'
    $result = $this_mobile.ldesc            if property == 'ldesc'
    $result = !$this_mobile.no_wear_eq?     if property == 'can_wear?'
  else
    $result = 'UNKNOWN'
  end
  return $result
end

def get_string_vnum(i)
  if i == -1
    return '-1'
    else
    if  AreaString.exists?(:id => i)
      return AreaString.find(i).formal_vnum
    else
      return 'UNKNOWN'
    end
  end
end

def is_local_obj(area, id)
  if Obj.exists?(:id => id)
    if Obj.find(id).area == area # If area matches...
      return true
    else
      return false
    end
  else
    return false
  end
end