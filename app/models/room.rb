class Room < ActiveRecord::Base
  belongs_to :area
  has_many :rxdescs, dependent: :destroy
  has_many :exits, dependent: :destroy
  has_many :room_specials, dependent: :destroy
  has_many :triggers, through: :exits, :source => :triggers

  include Bitfields
  bitfield :room_flags,
                2**0 =>  :dark,          # Dec:          1 / Hex:         1
                2**1 =>  :no_sleep,      # Dec:          2 / Hex:         2
                2**2 =>  :no_mob,        # Dec:          4 / Hex:         4
                2**3 =>  :indoors,       # Dec:          8 / Hex:         8
                2**4 =>  :guild,         # Dec:         16 / Hex:        10
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

  validates :vnum, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   :less_than => :max_vnum,
                                   message: "Can't exceed max allowable vnum."
                                  },
                   uniqueness:   { scope: :area,
                                   message: "No duplicate vnums allowed." }

  validates :name, length: { in: 4..80 }
  validates :description, length: { minimum: 4 }#, format: { with: /\A[\x0A\x0D -~]+\z/ }
  validates :terrain, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate do |room|
    room.errors.add :base, "Name may only contain US-ASCII characters.  Invalid characters: " + room.name.remove(/[\x0A\x0D -~]/) if room.name.remove(/[\x0A\x0D -~]/).length > 0
    room.errors.add :base, "Description may only contain US-ASCII characters.  Invalid characters: " + room.description.remove(/[\x0A\x0D -~]/) if room.description.remove(/[\x0A\x0D -~]/).length > 0
  end

  before_create :default_values
  def default_values
    self.room_flags ||= 0
    self.terrain ||= 0
  end

  def max_vnum
    area.vnum_qty
  end

  def formal_vnum
    (area.area_number * 100) + self.vnum
  end

  def next_room
    $next_room = false # return self if no next room
    x = self.vnum + 1
    for i in x..self.area.vnum_qty
      if self.area.rooms.exists?(:vnum => i)
        $next_room = self.area.rooms.where(:vnum => i).first
        break
      end
    end
    return $next_room
  end

  def last_room
    $last_room = false # return self if no last room
    i = self.vnum
    until i < 0
      i -= 1
      if self.area.rooms.exists?(:vnum => i)
        $last_room = self.area.rooms.where(:vnum => i).first
        break
      end
    end
    return $last_room
  end

  def any_bad_exits?
    $result = false
    self.exits.each do |exit|
      if exit.is_bad?
        $result = true
      end
    end
    return $result
  end

  def any_external_exits?
    $result = false
    self.exits.each do |exit|
      if exit.is_external?
        $result = true
      end
    end
    return $result
  end

  def any_illogical_exits?
    $result = false
    self.exits.each do |exit|
      if exit.is_illogical?
        $result = true
      end
    end
    return $result
  end

  def any_loopback_exits?
    $result = false
    self.exits.each do |exit|
      if exit.is_loopback?
        $result = true
      end
    end
    return $result
  end

  def any_oneway_exits?
    $result = false
    self.exits.each do |exit|
      if exit.is_one_way?
        $result = true
      end
    end
    return $result
  end

  def any_door_mismatches?
    $result = false
    self.exits.each do |exit|
      if exit.reciprocal_door_mismatch?
        $result = true
      end
    end
    return $result
  end

  def exit_dir_exists?(i)
    $result = false
    self.exits.each do |exit|
      if exit.direction == i
        $result = true
      end
    end
    return $result
  end

  def vnum_and_name
    return  format("%03d",self.vnum) + " " + self.name
  end

  def terrain_word
    $result = 'INSIDE'
    $result = 'CITY' if self.terrain == 1
    $result = 'FIELD' if self.terrain == 2
    $result = 'FOREST' if self.terrain == 3
    $result = 'HILLS' if self.terrain == 4
    $result = 'MOUNTAIN' if self.terrain == 5
    $result = 'WATER SWIM' if self.terrain == 6
    $result = 'WATER NOSWIM' if self.terrain == 7
    $result = 'UNDERWATER' if self.terrain == 8
    $result = 'AIR' if self.terrain == 9
    $result = 'DESERT' if self.terrain == 10
    return $result
  end

  def room_flags_as_string
    $flags_string = ''
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }DARK" if self.dark
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_SLEEP" if self.no_sleep
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_MOB" if self.no_mob
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }INDOORS" if self.indoors
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }GUILD" if self.guild
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }FOGGY" if self.foggy
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }FIRE" if self.fire
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }LAVA" if self.lava
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }PRIVATE" if self.private_room
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }PEACEFUL" if self.peaceful
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }SOLITARY" if self.solitary
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_RECALL" if self.no_recall
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_STEAL" if self.no_steal
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_TRANS" if self.notrans
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_SPELL" if self.no_spell
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }SEAFLOOR" if self.seafloor
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_FLY" if self.no_fly
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }HOLY_GROUND" if self.holy_ground
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }FLY_OK" if self.fly_ok
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_QUEST" if self.no_quest
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_ITEM" if self.no_item
    $flags_string = "#{$flags_string}#{' ' if $flags_string.length > 0 }NO_VNUM" if self.no_vnum
    return $flags_string
  end

  def has_contents?
    if self.area.resets.where(reset_type: ['M', 'Q', 'O']).where(val_4: self.id).count > 0
      return true
    else
      return false
    end
  end

  def unknown_room_flags
    value = self.room_flags
    value = value - 2**0 if self.dark
    value = value - 2**1 if self.no_sleep
    value = value - 2**2 if self.no_mob
    value = value - 2**3 if self.indoors
    value = value - 2**4 if self.guild
    value = value - 2**5 if self.foggy
    value = value - 2**6 if self.fire
    value = value - 2**7 if self.lava
   #value = value - 2**8 if self.???
    value = value - 2**9 if self.private_room
    value = value - 2**10 if self.peaceful
    value = value - 2**11 if self.solitary
   #value = value - 2**12 if self.???
    value = value - 2**13 if self.no_recall
    value = value - 2**14 if self.no_steal
    value = value - 2**15 if self.notrans
    value = value - 2**16 if self.no_spell
    value = value - 2**17 if self.seafloor
    value = value - 2**18 if self.no_fly
    value = value - 2**19 if self.holy_ground
    value = value - 2**20 if self.fly_ok
    value = value - 2**21 if self.no_quest
    value = value - 2**22 if self.no_item
    value = value - 2**23 if self.no_vnum
    return value
  end

end