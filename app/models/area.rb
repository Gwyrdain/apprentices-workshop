require_relative '_import'
require_relative '_translate'
require_relative '_lookup'

class Area < ActiveRecord::Base
  belongs_to :user
  has_many :helps, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :objs, dependent: :destroy
  has_many :mobiles, dependent: :destroy
  has_many :area_strings, dependent: :destroy
  has_many :resets, dependent: :destroy
  has_many :shares, dependent: :destroy
  
  has_many :applies, through: :objs
  has_many :oxdescs, through: :objs
  has_many :shops, through: :mobiles
  has_many :specials, through: :mobiles
  has_many :exits, through: :rooms
  has_many :rxdescs, through: :rooms
  has_many :room_specials, through: :rooms
  has_many :sub_resets, through: :resets
  has_many :triggers, through: :rooms, :source => :triggers
  
  include Bitfields
  
  bitfield :misc_flags,
                    2**0 => :share_publicly,
                    2**1 => :use_rulers,
                    2**2 => :show_formatted_blocks
  
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
  
  validate do |area|
    area.errors.add :base, "Name may only contain US-ASCII characters.  Invalid characters: " + area.name.remove(/[\x0A\x0D -~]/) if area.name.remove(/[\x0A\x0D -~]/).length > 0
    area.errors.add :base, "Author may only contain US-ASCII characters.  Invalid characters: " + area.author.remove(/[\x0A\x0D -~]/) if area.author.remove(/[\x0A\x0D -~]/).length > 0
  end

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
    
    area_file = file.read.encode(universal_newline: true).gsub(/\s*\n/,"\n")
    #lines = area_file.readlines.map(&:chomp) #readlines from file & removes newline symbol

    header_v1 = 'No Format 1 Area Header'
    header_v2 = 'No Format 2 Area Header'
    mobiles_block = 'No Mobiles Block'
    objects_block = 'No Objects Block'
    rooms_block = 'No Rooms Block'
    strings_block = 'No Strings Block'
    resets_block = 'No Resets Block'
    shops_block = 'No Shops Block'
    specials_block = 'No Specials Block'
    rspecs_block = 'No Room Specials Block'
    triggers_block = 'No Triggers Block'
    header_info = ''
    
    # Parse v1 Header Info
    if area_file.match(/^#AREA.*~.*?\n/)
      header_v1 = area_file.match(/^#AREA.*~.*?\n/)
      header_info = parse_area_header_v1(header_v1[0], user_id)
    end
    # Parse v2 Header Info
    if area_file.match(/^#AREA.*?\nEnd/m)
      header_v2 = area_file.match(/^#AREA.*?\nEnd/m)
      header_info = parse_area_header_v2(header_v2[0], user_id)
    end
    # Parse the Mobiles Block
    if area_file.match(/^#MOBILES\n#(.*?)\n#0/m)
      mobiles_block = parse_mobiles( area_file.match(/^#MOBILES\n#(.*?)\n#0/m)[1] )
    end
    # Parse the Objects Block
    if area_file.match(/^#OBJECTS\n#.*?\n#0/m)
      objects_block = parse_objects( area_file.match(/^#OBJECTS\n#(.*?)\n#0/m)[1] )
    end
    
    
    
    if area_file.match(/^#ROOMS\n#.*?\n#0/m)
      rooms_block = area_file.match(/^#ROOMS\n#(.*?)\n#0/m)
    end
    if area_file.match(/^#STRINGS\n#.*?\n#0/m)
      strings_block = area_file.match(/^#STRINGS\n#(.*?)\n#0/m)
    end
    if area_file.match(/^#RESETS\n.*?\nS/m)
      resets_block = area_file.match(/^#RESETS\n.*?\nS/m)
    end
    if area_file.match(/^#SHOPS\n.*?\n0/m)
      shops_block = area_file.match(/^#SHOPS\n.*?\n0/m)
    end
    if area_file.match(/^#SPECIALS\n.*?\nS/m)
      specials_block = area_file.match(/^#SPECIALS\n.*?\nS/m)
    end
    if area_file.match(/^#RSPECS\n.*?\nS/m)
      rspecs_block = area_file.match(/^#RSPECS\n.*?\nS/m)
    end
    if area_file.match(/^#TRIGGERS\n.*?\nS/m)
      triggers_block = area_file.match(/^#TRIGGERS\n.*?\nS/m)
    end

    return "#{header_info}<hr>#{header_v1}<hr>#{header_v2}<hr>#{mobiles_block}<hr>#{objects_block}<hr>" <<
           "#{rooms_block}<hr>#{strings_block}<hr>#{resets_block}<hr>#{shops_block}" <<
           "#{specials_block}<hr>#{rspecs_block}<hr>#{triggers_block}<hr><b>EOF</b>"

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

  def my_area
    return self
  end
  
  def last_updated?
    $latest_update = self.updated_at
    $update = $latest_update
    
    $update = self.area_strings.order(updated_at: :desc).first.updated_at if self.area_strings.count > 0
    $latest_update = $update           if $update > $latest_update
    
    $update = self.helps.order(updated_at: :desc).first.updated_at if self.helps.count > 0
    $latest_update = $update           if $update > $latest_update
    
    $update = self.rooms.order(updated_at: :desc).first.updated_at if self.rooms.count > 0
    $latest_update = $update           if $update > $latest_update
    
    $update = self.mobiles.order(updated_at: :desc).first.updated_at if self.mobiles.count > 0
    $latest_update = $update           if $update > $latest_update
    
    $update = self.objs.order(updated_at: :desc).first.updated_at if self.objs.count > 0
    $latest_update = $update           if $update > $latest_update
    
    $update = self.resets.order(updated_at: :desc).first.updated_at if self.resets.count > 0
    $latest_update = $update           if $update > $latest_update

    $update = self.shops.order(updated_at: :desc).first.updated_at if self.shops.count > 0
    $latest_update = $update           if $update > $latest_update

    $update = self.specials.order(updated_at: :desc).first.updated_at if self.specials.count > 0
    $latest_update = $update           if $update > $latest_update

    $update = self.room_specials.order(updated_at: :desc).first.updated_at if self.room_specials.count > 0
    $latest_update = $update           if $update > $latest_update

    $update = self.sub_resets.order(updated_at: :desc).first.updated_at if self.sub_resets.count > 0
    $latest_update = $update           if $update > $latest_update

    $update = self.triggers.order(updated_at: :desc).first.updated_at if self.triggers.count > 0
    $latest_update = $update           if $update > $latest_update

    $update = self.applies.order(updated_at: :desc).first.updated_at if self.applies.count > 0
    $latest_update = $update           if $update > $latest_update

    $update = self.exits.order(updated_at: :desc).first.updated_at if self.exits.count > 0
    $latest_update = $update           if $update > $latest_update

    $update = self.rxdescs.order(updated_at: :desc).first.updated_at if self.rxdescs.count > 0
    $latest_update = $update           if $update > $latest_update

    $update = self.oxdescs.order(updated_at: :desc).first.updated_at if self.oxdescs.count > 0
    $latest_update = $update           if $update > $latest_update
    
    return $latest_update
  end
  
  def self.import(file, user_id)

    range_low ||= 0
    range_high ||= 0
    author ||= ''
    name ||= ''
    flags ||= 0
    
    area_file = file.read.encode(universal_newline: true).gsub(/\s*\n/,"\n")

    header_info = nil
    helps_block = nil
    mobiles_block = nil
    objects_block = nil
    rooms_block = nil
    strings_block = nil
    
    resets_block = 'No Resets Block'
    shops_block = 'No Shops Block'
    specials_block = 'No Specials Block'
    rspecs_block = 'No Room Specials Block'
    triggers_block = 'No Triggers Block'
    
    if area_file.match(/^#AREA.*~.*?\n/) # v1 Header
      header_info = parse_area_header_v1( area_file.match(/^#AREA.*~.*?\n/)[0] )
    end
    
    if area_file.match(/^#AREA.*?\nEnd/m) # v2 Header
      header_info = parse_area_header_v2( area_file.match(/^#AREA.*?\nEnd/m)[0] )
    end

    if area_file.match(/^#HELPS\n(.*?)0 \$~/m)
      helps_block = parse_helps( area_file.match(/^#HELPS\n(.*?)0 \$~/m)[1] )
    end
    
    if area_file.match(/^#MOBILES\n#(.*?)\n#0/m)
      mobiles_block = parse_mobiles( area_file.match(/^#MOBILES\n#(.*?)\n#0/m)[1] )
    end

    if area_file.match(/^#OBJECTS\n#(.*?)\n#0/m)
      objects_block = parse_objects( area_file.match(/^#OBJECTS\n#(.*?)\n#0/m)[1] )
    end
    
    if area_file.match(/^#ROOMS\n#(.*?)\n#0/m)
      rooms_block = parse_rooms( area_file.match(/^#ROOMS\n#(.*?)\n#0/m)[1] )
    end
    
    if area_file.match(/^#STRINGS\n#.*?\n#0/m)
      strings_block = parse_strings( area_file.match(/^#STRINGS\n#(.*?)\n#0/m)[1] )
    end
    
    if area_file.match(/^#RESETS\n.*?\nS/m)
      resets_block = parse_resets( area_file.match(/^#RESETS\n(.*?)\nS/m)[1] )
    end
    if area_file.match(/^#SHOPS\n.*?\n0/m)
      shops_block = area_file.match(/^#SHOPS\n.*?\n0/m)
    end
    if area_file.match(/^#SPECIALS\n.*?\nS/m)
      specials_block = area_file.match(/^#SPECIALS\n.*?\nS/m)
    end
    if area_file.match(/^#RSPECS\n.*?\nS/m)
      rspecs_block = area_file.match(/^#RSPECS\n.*?\nS/m)
    end
    if area_file.match(/^#TRIGGERS\n.*?\nS/m)
      triggers_block = area_file.match(/^#TRIGGERS\n.*?\nS/m)
    end

    return "<h1>Header</h1>#{format_hash(header_info) if header_info != nil}<hr>" <<
           "<h1>Helps</h1>#{format_hash(helps_block) if helps_block != nil}<hr>" <<
           "<h1>Mobiles</h1>#{format_hash(mobiles_block) if mobiles_block != nil}<hr>" <<
           "<h1>Objects</h1>#{format_hash(objects_block) if objects_block != nil}<hr>" <<
           "<h1>Rooms</h1>#{format_hash(rooms_block) if rooms_block != nil}<hr>" <<
           "<h1>Strings</h1>#{format_hash(strings_block) if strings_block != nil}<hr>" <<
           "<h1>Resets</h1>#{format_hash(resets_block) if resets_block != nil}<hr>" #<<

  end
  
end

def format_hash(h)
  $formatted_hash = ''
  
    h.each do |item|
      $formatted_hash = $formatted_hash + "<b>#{item[0]}:</b> "
      if item[1].class.name == "Hash"
        $formatted_hash = $formatted_hash + "<table border=\"1\"><tr><td>#{format_hash(item[1])}</td></tr></table>"
      else
        $formatted_hash = $formatted_hash + "#{item[1]}<br>"
      end
    end
  
  return $formatted_hash
end

def parse_resets (resets_block)
  resets_info = Hash.new
  i = 1
  
  resets_block.gsub!(/^\*.*\n/,'')
  resets = resets_block.split(/\n/).map(&:strip)
  
  resets.each do |reset|
    reset_info = Hash.new

    m = reset.match(/(\w) (\d*) (\d*) (\d*)/)
    if m
      reset_info["reset_type"] = m[1].strip
      reset_info["reset_v0"]   = m[2].to_i
      reset_info["reset_v1"]   = m[3].to_i
      reset_info["reset_v2"]   = m[4].to_i
    end
    
    m = reset.match(/\w \d* \d* \d* (\d*)/)
    if m
      reset_info["reset_v3"]   = m[1].to_i
    end
    
    resets_info[i] = reset_info
    i = i + 1  
  end
  
  return resets_info
end