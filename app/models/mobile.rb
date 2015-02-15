class Mobile < ActiveRecord::Base
  belongs_to :area
  
  has_many :specials, dependent: :destroy
  has_many :shops, dependent: :destroy

  include Bitfields

  bitfield :act_flags,
#               2**0 =>  :flag,          # Dec:          1 / Hex:         1
                2**1 =>  :sentinel,      # Dec:          2 / Hex:         2
                2**2 =>  :scavenger,     # Dec:          4 / Hex:         4
                2**3 =>  :plant,         # Dec:          8 / Hex:         8
#               2**4 =>  :flag,          # Dec:         16 / Hex:        10
                2**5 =>  :aggressive,    # Dec:         32 / Hex:        20
                2**6 =>  :stay_area,     # Dec:         64 / Hex:        40
                2**7 =>  :wimpy,         # Dec:        128 / Hex:        80
#               2**8 =>  :flag,          # Dec:        256 / Hex:       100
                2**9 =>  :train,         # Dec:        512 / Hex:       200
                2**10 => :practice,      # Dec:       1024 / Hex:       400
                2**11 => :super_wimpy,   # Dec:       2048 / Hex:       800
                2**12 => :assist_same,   # Dec:       4096 / Hex:      1000
                2**13 => :assist,        # Dec:       8192 / Hex:      2000
                2**14 => :assist_always, # Dec:      16384 / Hex:      4000
                2**15 => :swim,          # Dec:      32768 / Hex:      8000
                2**16 => :water_only,    # Dec:      65536 / Hex:     10000
#               2**17 => :flag,          # Dec:     131072 / Hex:     20000
                2**18 => :animal,        # Dec:     262144 / Hex:     40000
                2**19 => :no_wear_eq,    # Dec:     524288 / Hex:     80000
                2**20 => :no_corpse,     # Dec:    1048576 / Hex:    100000
#               2**21 => :flag,          # Dec:    2097152 / Hex:    200000
#               2**22 => :flag,          # Dec:    4194304 / Hex:    400000
                2**23 => :fireproof,     # Dec:    8388608 / Hex:    800000
                2**24 => :intelligent,   # Dec:   16777216 / Hex:   1000000
#               2**25 => :flag,          # Dec:   33554432 / Hex:   2000000
                2**26 => :cloaked,       # Dec:   67108864 / Hex:   4000000
                2**27 => :no_random_eq   # Dec:  134217728 / Hex:   8000000
#               2**28 => :flag,          # Dec:  268435456 / Hex:  10000000
#               2**29 => :flag,          # Dec:  536870912 / Hex:  20000000
#               2**30 => :flag,          # Dec: 1073741824 / Hex:  40000000
#               2**31 => :flag,          # Dec: 2147483648 / Hex:  80000000
#               2**32 => :flag,          # Dec: 4294967296 / Hex: 100000000

  bitfield :affect_flags,
                2**0 =>  :blind,               # Dec:          1 / Hex:         1
                2**1 =>  :invisible,           # Dec:          2 / Hex:         2
                2**2 =>  :detect_evil,         # Dec:          4 / Hex:         4
                2**3 =>  :detect_invis,        # Dec:          8 / Hex:         8
                2**4 =>  :detect_magic,        # Dec:         16 / Hex:        10
                2**5 =>  :detect_hidden,       # Dec:         32 / Hex:        20
                2**6 =>  :detect_good,         # Dec:         64 / Hex:        40
                2**7 =>  :sanctuary,           # Dec:        128 / Hex:        80
                2**8 =>  :faerie_fire,         # Dec:        256 / Hex:       100
                2**9 =>  :infrared,            # Dec:        512 / Hex:       200
                2**10 => :curse,               # Dec:       1024 / Hex:       400
                2**11 => :no_steal,            # Dec:       2048 / Hex:       800
                2**12 => :poison,              # Dec:       4096 / Hex:      1000
                2**13 => :protect_from_evil,   # Dec:       8192 / Hex:      2000
                2**14 => :protect_from_good,   # Dec:      16384 / Hex:      4000
                2**15 => :sneak,               # Dec:      32768 / Hex:      8000
                2**16 => :hide,                # Dec:      65536 / Hex:     10000
                2**17 => :sleep,               # Dec:     131072 / Hex:     20000
                2**18 => :charm,               # Dec:     262144 / Hex:     40000
                2**19 => :flying,              # Dec:     524288 / Hex:     80000
                2**20 => :passdoor,            # Dec:    1048576 / Hex:    100000
                2**21 => :no_trace,            # Dec:    2097152 / Hex:    200000
                2**22 => :no_sleep,            # Dec:    4194304 / Hex:    400000
                2**23 => :no_summon,           # Dec:    8388608 / Hex:    800000
                2**24 => :no_charm,            # Dec:   16777216 / Hex:   1000000
#               2**25 => :flag,                # Dec:   33554432 / Hex:   2000000
#               2**26 => :flag,                # Dec:   67108864 / Hex:   4000000
                2**27 => :improved_invis       # Dec:  134217728 / Hex:   8000000
#               2**28 => :flag,                # Dec:  268435456 / Hex:  10000000
#               2**29 => :flag,                # Dec:  536870912 / Hex:  20000000
#               2**30 => :flag,                # Dec: 1073741824 / Hex:  40000000
#               2**31 => :flag,                # Dec: 2147483648 / Hex:  80000000
#               2**32 => :flag,                # Dec: 4294967296 / Hex: 100000000
  
  bitfield :langs_known, 
                2**0 =>  :common,        # Dec:          1 / Hex:         1
                2**1 =>  :dwarven,       # Dec:          2 / Hex:         2
                2**2 =>  :elven,         # Dec:          4 / Hex:         4
                2**3 =>  :gnomish,       # Dec:          8 / Hex:         8
                2**4 =>  :halfling,      # Dec:         16 / Hex:        10
                2**5 =>  :aarakocra,     # Dec:         32 / Hex:        20
                2**6 =>  :giant,         # Dec:         64 / Hex:        40
                2**7 =>  :minotaur,      # Dec:        128 / Hex:        80
                2**8 =>  :ogre,          # Dec:        256 / Hex:       100
                2**9 =>  :thoras,        # Dec:        512 / Hex:       200
                2**10 => :goblin,        # Dec:       1024 / Hex:       400
                2**11 => :drow,          # Dec:       2048 / Hex:       800
                2**12 => :kobold,        # Dec:       4096 / Hex:      1000
                2**13 => :orc,           # Dec:       8192 / Hex:      2000
                2**14 => :troll,         # Dec:      16384 / Hex:      4000
                2**15 => :sahaguin,      # Dec:      32768 / Hex:      8000
                2**16 => :god            # Dec:      65536 / Hex:     10000

  validates :vnum, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   :less_than => :max_vnum,
                                   message: "Can't exceed max allowable vnum."
                                  },
                   uniqueness:   { scope: :area,
                                   message: "No duplicate vnums allowed." }
  validates :keywords, length: { in: 3..75 }
  validates :sdesc, length: { in: 4..75 }
  validates :ldesc, length: { in: 4..75 }
  validates :look_desc, length: { minimum: 4 }
  validates :act_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :affect_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :alignment, numericality: { only_integer: true }  
  validates :level, numericality: { only_integer: true, greater_than: 0 }
  validates :sex, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :langs_known, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :lang_spoken, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :default_values
  def default_values
    self.act_flags ||= 64
    self.affect_flags ||= 0
    self.alignment ||= 0
    self.level ||= 1
    self.sex ||= 0
    self.langs_known ||= 0
    self.lang_spoken ||= 0
  end

  def max_vnum
    area.vnum_qty
  end
  
  def formal_vnum
    (area.area_number * 100) + self.vnum
  end

  def vnum_and_sdesc
    return  format("%03d",self.vnum) + " " + self.sdesc
  end
  
  def has_assoc_reset?
    if self.area.resets.where(:reset_type => 'M', :val_2 => self.id).count > 0
      return true
    else
      return false
    end
  end
  
  def sex_word
    $sex = nil
    $sex = 'none'    if self.sex == 0
    $sex = 'male'    if self.sex == 1
    $sex = 'female'  if self.sex == 2
    return $sex
  end
  
  def alignment_word
    $alignment = nil
    $alignment = 'evil'    if self.alignment == -1000
    $alignment = 'unaligned'    if self.alignment == 0
    $alignment = 'good'  if self.alignment == 1000
    return $alignment
  end

end

def lang_from_num(i)
  $lang = nil
  $lang = 'NONE'    if i == 0
  $lang = 'COMMON'    if i == 1
  $lang = 'DWARVEN'   if i == 2
  $lang = 'ELVEN'     if i == 4
  $lang = 'GNOMISH'   if i == 8
  $lang = 'HALFLING'  if i == 16
  $lang = 'AARAKOCRA' if i == 32
  $lang = 'GIANT'     if i == 64
  $lang = 'MINOTAUR'  if i == 128
  $lang = 'OGRE'      if i == 256
  $lang = 'THORAS'    if i == 512
  $lang = 'GOBLIN'    if i == 1024
  $lang = 'DROW'      if i == 2048
  $lang = 'KOBOLD'    if i == 4096
  $lang = 'ORC'       if i == 8192
  $lang = 'TROLL'     if i == 16384
  $lang = 'SAHAGUIN'  if i == 32768
  $lang = 'GOD'       if i == 65535
  return $lang.upcase
end