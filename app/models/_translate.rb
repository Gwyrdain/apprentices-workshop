# Translate between numbers and strings

def num_to_dir(i)
  $word = nil
  $word = 'North' if i == 0
  $word = 'East' if i == 1
  $word = 'South' if i == 2
  $word = 'West' if i == 3
  $word = 'Up' if i == 4
  $word = 'Down' if i == 5
  return $word
end

def opposite_dir(i)
  $dir = nil
  $dir = 0 if i == 2  # N opposite of S
  $dir = 2 if i == 0  # S opposite of N
  $dir = 1 if i == 3  # E opposite of W
  $dir = 3 if i == 1  # W opposite of E
  $dir = 4 if i == 5  # U opposite of D
  $dir = 5 if i == 4  # D opposite of U
  return $dir
end

def hour_from_num(i)
  $hour = nil
  $hour = '12AM' if i == 0
  $hour = '1AM' if i == 1
  $hour = '2AM' if i == 2
  $hour = '3AM' if i == 3
  $hour = '4AM' if i == 4
  $hour = '5AM' if i == 5
  $hour = '6AM' if i == 6
  $hour = '7AM' if i == 7
  $hour = '8AM' if i == 8
  $hour = '9AM' if i == 9
  $hour = '10AM' if i == 10
  $hour = '11AM' if i == 11
  $hour = '12PM' if i == 12
  $hour = '1PM' if i == 13
  $hour = '2PM' if i == 14
  $hour = '3PM' if i == 15
  $hour = '4PM' if i == 16
  $hour = '5PM' if i == 17
  $hour = '6PM' if i == 18
  $hour = '7PM' if i == 19
  $hour = '8PM' if i == 20
  $hour = '9PM' if i == 21
  $hour = '10PM' if i == 22
  $hour = '11PM' if i == 23
  return $hour
end

def race_from_num(i)
  $race = nil
  $race = 'no one' if i == -1
  $race = 'humans' if i == 0
  $race = 'dwarves' if i == 1
  $race = 'elves' if i == 2
  $race = 'gnomes' if i == 3
  $race = 'halfelves' if i == 4
  $race = 'halflings' if i == 5
  $race = 'aarakocra' if i == 6
  $race = 'giants' if i == 7
  $race = 'minotaurs' if i == 8
  $race = 'ogres' if i == 9
  return $race
end

def object_type_from_num(i)
  $object_type = nil
  $object_type = 'N/A' if i == 0
  $object_type = 'ARMOR' if i == 9
  $object_type = 'ARMOR ANIMAL' if i == 14
  $object_type = 'BOAT' if i == 22
  $object_type = 'CONTAINER' if i == 15
  $object_type = 'DECORATION' if i == 27
  $object_type = 'DRINK CONTAINER' if i == 17
  $object_type = 'FETISH' if i == 7
  $object_type = 'FOOD' if i == 19
  $object_type = 'FOUNTAIN' if i == 25
  $object_type = 'FURNITURE' if i == 12
  $object_type = 'JEWELRY' if i == 30
  $object_type = 'KEY' if i == 18
  $object_type = 'LIGHT' if i == 1
  $object_type = 'MONEY' if i == 20
  $object_type = 'PET FOOD' if i == 11
  $object_type = 'PILL' if i == 26
  $object_type = 'POTION' if i == 10
  $object_type = 'RELIC' if i == 33
  $object_type = 'RING' if i == 29
  $object_type = 'SCROLL' if i == 2
  $object_type = 'STAFF' if i == 4
  $object_type = 'TRASH' if i == 13
  $object_type = 'TREASURE' if i == 8
  $object_type = 'WAND' if i == 3
  $object_type = 'WEAPON' if i == 5
  $object_type = 'WEAPON ANIMAL' if i == 6
  return $object_type
end

def num_to_exits(i)
  $exit_list = nil
  $exit_list = 'n' if i == 0
  $exit_list = 'n, e' if i == 1
  $exit_list = 'n, e, s' if i == 2
  $exit_list = 'n, e, s, w' if i == 3
  $exit_list = 'n, e, s, w, u' if i == 4
  $exit_list = 'n, e, s, w, u, d' if i == 5
  return $exit_list
end

def num_to_attribute(i)
  $attribute = nil
  $attribute = 'STR' if i == 0
  $attribute = 'INT' if i == 1
  $attribute = 'WIS' if i == 2
  $attribute = 'DEX' if i == 3
  $attribute = 'CON' if i == 4
  $attribute = 'CHR' if i == 5
  $attribute = 'LUC' if i == 6
  return $attribute
end

def door_state(i)
  $state = nil
  $state = 'open' if i == 0
  $state = 'closed' if i == 1
  $state = 'closed+locked' if i == 2
  return $state
end

def area_flag_as_number( flag_name )
  flag_name = flag_name.upcase
  $number = 0
  $number = 2**0 if flag_name == 'MANMADE'
  $number = 2**1 if flag_name == 'CITY'
  $number = 2**2 if flag_name == 'FOREST'
  $number = 2**3 if flag_name == 'LIMITED'
  $number = 2**4 if flag_name == 'AERIAL'
  $number = 2**5 if flag_name == 'RESERVED'
  $number = 2**6 if flag_name == 'ARENA'
  $number = 2**7 if flag_name == 'QUEST'
  $number = 2**8 if flag_name == 'NOVNUM'
  $number = 2**9 if flag_name == 'NOSAVE'
  return $number
end

def apply_type_name(apply_type)
  name = ''
  name = 'STR'                if apply_type == 1
  name = 'DEX'                if apply_type == 2
  name = 'INT'                if apply_type == 3
  name = 'WIS'                if apply_type == 4
  name = 'CON'                if apply_type == 5
  name = 'MANA'               if apply_type == 12
  name = 'HIT'                if apply_type == 13
  name = 'MOVE'               if apply_type == 14
  name = 'AC'                 if apply_type == 17
  name = 'HITROLL'            if apply_type == 18
  name = 'DAMROLL'            if apply_type == 19
  name = 'SAVE V SPELL'       if apply_type == 24
  name = 'CHARISMA'           if apply_type == 25
  name = 'LUCK'               if apply_type == 26
  name = 'NOSTEAL'            if apply_type == 27
  name = 'NOSLEEP'            if apply_type == 28
  name = 'NOSUMMON'           if apply_type == 29
  name = 'NOCHARM'            if apply_type == 30
  name = 'NOSEXCHANGE'        if apply_type == 31
  name = 'TRUESEE'            if apply_type == 32
  name = 'NOINFO'             if apply_type == 33
  name = 'WATERBREATH'        if apply_type == 34
  name = 'DAMAGE ABSORPTION'  if apply_type == 41
  name = 'MAGICAL RESISTANCE' if apply_type == 43
  return name
end
