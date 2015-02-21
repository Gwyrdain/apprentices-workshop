class Area < ActiveRecord::Base
  belongs_to :user
  has_many :helps, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :objs, dependent: :destroy
  has_many :mobiles, dependent: :destroy
  has_many :area_strings, dependent: :destroy
  has_many :resets, dependent: :destroy
  has_many :shares, dependent: :destroy
  
  has_many :shops, through: :mobiles
  has_many :specials, through: :mobiles
  has_many :room_specials, through: :rooms
  has_many :sub_resets, through: :resets
  has_many :triggers, through: :rooms, :source => :triggers
  
  include Bitfields
  
  bitfield :misc_flags,
                    2**0 => :share_publicly,
                    2**1 => :use_rulers
  
  bitfield  :flags, 2**0 => :manmade,  # Hex 1
                    2**1 => :city,     # Hex 2
                    2**2 => :forest,   # Hex 4
                    2**3 => :limited,  # Hex 8
                    2**4 => :aerial,   # Hex 10
                    2**5 => :reserved, # Hex 20
                    2**6 => :arena,    # Hex 40
                    2**7 => :quest,    # Hex 80
                    2**8 => :novnum,   # Hex 100
                    2**9 => :no_save   # Hex 200
                    
  bitfield :default_room_flags, 
                2**0 =>  :dark,          # Dec:          1 / Hex:         1
                2**1 =>  :no_sleep,      # Dec:          2 / Hex:         2
                2**2 =>  :no_mob,        # Dec:          4 / Hex:         4
                2**3 =>  :indoors,       # Dec:          8 / Hex:         8
#               2**4 =>  :flag,          # Dec:         16 / Hex:        10
                2**5 =>  :foggy,         # Dec:         32 / Hex:        20
                2**6 =>  :fire,          # Dec:         64 / Hex:        40
                2**7 =>  :lava,          # Dec:        128 / Hex:        80
#               2**8 =>  :flag,          # Dec:        256 / Hex:       100
                2**9 =>  :private_room,  # Dec:        512 / Hex:       200
                2**10 => :peaceful,      # Dec:       1024 / Hex:       400
                2**11 => :solitary,      # Dec:       2048 / Hex:       800
#               2**12 => :flag,          # Dec:       4096 / Hex:      1000
                2**13 => :no_recall,     # Dec:       8192 / Hex:      2000
                2**14 => :no_steal,      # Dec:      16384 / Hex:      4000
                2**15 => :notrans,       # Dec:      32768 / Hex:      8000
                2**16 => :no_spell,      # Dec:      65536 / Hex:     10000
                2**17 => :seafloor,      # Dec:     131072 / Hex:     20000
                2**18 => :no_fly,        # Dec:     262144 / Hex:     40000
                2**19 => :holy_ground,   # Dec:     524288 / Hex:     80000
                2**20 => :fly_ok,        # Dec:    1048576 / Hex:    100000
                2**21 => :no_quest,      # Dec:    2097152 / Hex:    200000
                2**22 => :no_item,       # Dec:    4194304 / Hex:    400000
                2**23 => :no_vnum        # Dec:    8388608 / Hex:    800000
#               2**24 => :flag,          # Dec:   16777216 / Hex:   1000000
#               2**25 => :flag,          # Dec:   33554432 / Hex:   2000000
#               2**26 => :flag,          # Dec:   67108864 / Hex:   4000000
#               2**27 => :flag,          # Dec:  134217728 / Hex:   8000000
#               2**28 => :flag,          # Dec:  268435456 / Hex:  10000000
#               2**29 => :flag,          # Dec:  536870912 / Hex:  20000000
#               2**30 => :flag,          # Dec: 1073741824 / Hex:  40000000
#               2**31 => :flag,          # Dec: 2147483648 / Hex:  80000000
#               2**32 => :flag,          # Dec: 4294967296 / Hex: 100000000

  validates :name, length: { in: 1..20 }
  validates :author, length: { in: 1..75 }

  validates :vnum_qty, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :lowlevel, numericality: { only_integer: true, greater_than: 0, less_than: 51  }
  validates :highlevel, numericality: { only_integer: true, greater_than: 0, less_than: 51  }
  validates :default_terrain, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :area_number,  numericality: { only_integer: true, greater_than: 0 }
  validates :user_id,  numericality: { only_integer: true, greater_than: 0 }

  before_create :default_values
  def default_values
    self.flags ||= 0
    self.vnum_qty ||= 100
    self.misc_flags ||= 0
    self.default_terrain ||= 0
    self.default_room_flags ||= 0
    return true
  end
  
  def self.import(file, user_id)

    range_low ||= 0
    range_high ||= 0
    author ||= ''
    name ||= ''
    flags ||= 0
    
    lines = file.tempfile.readlines.map(&:chomp) #readlines from file & removes newline symbol
    lines.each do |l| 
      if (l.include?("#AREA") && l.include?("~")) # FORMAT 1 Area Header
        m = l.match(/\{(.*)\} (........) (.*)~\s*F (\d+)/)

        if m
          author = m[2].strip
          name = m[3].strip
          flags = m[4].to_i
  
          if m[1].match(/(\d) (\d)/)
            range = m[1].match(/(\d+) (\d+)/)
              range_low = range[1].to_i
              range_high = range[2].to_i
          else
            if m[1].match(/ALL/)
              range_low = 1
              range_high = 50
            end
            if m[1].match(/HARD/)
              range_low = 50
              range_high = 50
            end
          end
        end

      end # #AREA Format 1
      
      if read_area_block == true
        #do something
        
        if l.match(/^End/) # FORMAT 2 Area Header
          read_area_block = false # stop reading the area block
          # process area block
        end
        
      end
        
      if (l.match(/^#AREA/) && !l.include?("~")) # FORMAT 2 Area Header
        read_area_block = true # start reading the area block
      end

      
    end # lines do
    
   #@area = Area.create!({name: name, author: author, lowlevel: range_low, highlevel: range_high, flags: flags, vnum_qty: 100, area_number: 1, default_terrain: 0, user_id: user_id})

    
  
  end
  
  def nextroomvnum
    $i = 0
    while self.rooms.exists?(:vnum => $i)  do
        $i +=1
    end
    return $i
  end
  
  def nextobjvnum
    $i = 0
    while self.objs.exists?(:vnum => $i)  do
        $i +=1
    end
    return $i
  end

  def nextmobilevnum
    $i = 0
    while self.mobiles.exists?(:vnum => $i)  do
        $i +=1
    end
    return $i
  end

  def nextarea_stringvnum
    $i = 0
    while self.area_strings.exists?(:vnum => $i)  do
        $i +=1
    end
    return $i
  end
  
  def flags_as_hex
    #return self.flags.to_s(16).upper ... trying new
    return "%X" % self.flags
  end
  
  def flags_as_string
    $flags_string = ''
    $flags_string = $flags_string + ' MANMADE' if self.manmade
    $flags_string = $flags_string + ' CITY' if self.city
    $flags_string = $flags_string + ' FOREST' if self.forest
    $flags_string = $flags_string + ' LIMITED' if self.limited
    $flags_string = $flags_string + ' AERIAL' if self.aerial
    $flags_string = $flags_string + ' RESERVED' if self.reserved
    $flags_string = $flags_string + ' ARENA' if self.arena
    $flags_string = $flags_string + ' QUEST' if self.quest
    $flags_string = $flags_string + ' NOVNUM' if self.novnum
    $flags_string = $flags_string + ' NOSAVE' if self.no_save
    return $flags_string
  end
  
  def door_reset_count
    i = 0
    self.rooms.each do |room|

      room.exits.each do |exit|
        i = i + 1 if exit.has_reset?
      end

    end
    return i
  end
  
  def shared_with?(this_user)
#   if ( this_user.id == self.user_id || self.share_publicly? || this_user.is_admin? || self.shares.exists?(:user_id => this_user.id ) )
    if self.shares.exists?(:user_id => this_user.id )
      return true
    else
      return false
    end
  end
    
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



# functions to fetch Room, Object, Mobile retated strings
def obj_info(id, property)
  $result = nil
  if Obj.exists?(:id => id)
    $this_obj = Obj.find(id)
    $result = $this_obj.formal_vnum.to_s if property == 'formal_vnum'
    $result = $this_obj.sdesc            if property == 'sdesc'
    $result = $this_obj.type_word        if property == 'type_word'
  else
    $result = 'UNKNOWN'
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
    $result = $this_mobile.sdesc             if property == 'sdesc'
  else
    $result = 'UNKNOWN'
  end
  return $result
end