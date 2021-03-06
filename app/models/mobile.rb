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
  validates :keywords, length: { in: 0..80 }
  validates :sdesc, length: { in: 0..80 }
  validates :ldesc, length: { in: 0..160 }
  validates :look_desc, length: { minimum: 0 }#, format: { with: /\A[\x0A\x0D -}]+\z/}
  validates :act_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :affect_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :alignment, numericality: { only_integer: true }
  validates :level, numericality: { only_integer: true, greater_than: 0 }
  validates :sex, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :langs_known, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :lang_spoken, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate do |mobile|
    mobile.errors.add :base, "Keywords may only contain US-ASCII characters.  Invalid characters: " + mobile.keywords.remove(/[\x0A\x0D -}]/) if mobile.keywords.remove(/[\x0A\x0D -}]/).length > 0
    mobile.errors.add :base, "Short description may only contain US-ASCII characters.  Invalid characters: " + mobile.sdesc.remove(/[\x0A\x0D -}]/) if mobile.sdesc.remove(/[\x0A\x0D -}]/).length > 0
    mobile.errors.add :base, "Long description may only contain US-ASCII characters.  Invalid characters: " + mobile.ldesc.remove(/[\x0A\x0D -}]/) if mobile.ldesc.remove(/[\x0A\x0D -}]/).length > 0
    mobile.errors.add :base, "Look description may only contain US-ASCII characters.  Invalid characters: " + mobile.look_desc.remove(/[\x0A\x0D -}]/) if mobile.look_desc.remove(/[\x0A\x0D -}]/).length > 0
  end

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

  def next_mobile
    next_mobile = false # return self if no next mobile
    x = self.vnum + 1
    for i in x..self.area.vnum_qty
      if self.area.mobiles.exists?(:vnum => i)
        next_mobile = self.area.mobiles.where(:vnum => i).first
        break
      end
    end
    return next_mobile
  end

  def last_mobile
    last_mobile = false # return self if no last mobile
    i = self.vnum
    until i < 0
      i -= 1
      if self.area.mobiles.exists?(:vnum => i)
        last_mobile = self.area.mobiles.where(:vnum => i).first
        break
      end
    end
    return last_mobile
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

  def count_resets
    return self.area.resets.where(:reset_type => 'M', :val_2 => self.id).count
  end

  def sex_word
    sex = nil
    sex = 'none'    if self.sex == 0
    sex = 'male'    if self.sex == 1
    sex = 'female'  if self.sex == 2
    return sex
  end

  def alignment_word
    alignment = nil
    alignment = 'evil'    if self.alignment < 0
    alignment = 'unaligned'    if self.alignment == 0
    alignment = 'good'  if self.alignment > 0
    return alignment
  end

  def act_flags_list
    list = Array.new
    list.push('sentinel') if self.sentinel
    list.push('scavenger') if self.scavenger
    list.push('plant') if self.plant
    list.push('aggressive') if self.aggressive
    list.push('stay_area') if self.stay_area
    list.push('wimpy') if self.wimpy
    list.push('train') if self.train
    list.push('practice') if self.practice
    list.push('super_wimpy') if self.super_wimpy
    list.push('assist_same') if self.assist_same
    list.push('assist') if self.assist
    list.push('assist_always') if self.assist_always
    list.push('swim') if self.swim
    list.push('water_only') if self.water_only
    list.push('animal') if self.animal
    list.push('no_wear_eq') if self.no_wear_eq
    list.push('no_corpse') if self.no_corpse
    list.push('fireproof') if self.fireproof
    list.push('intelligent') if self.intelligent
    list.push('cloaked') if self.cloaked
    list.push('no_random_eq') if self.no_random_eq
    return list.to_sentence.humanize.titleize.gsub(/And/,'and')
  end

  def affect_flags_list
    list = Array.new
    list.push('blind') if self.blind
    list.push('invisible') if self.invisible
    list.push('detect_evil') if self.detect_evil
    list.push('detect_invis') if self.detect_invis
    list.push('detect_magic') if self.detect_magic
    list.push('detect_hidden') if self.detect_hidden
    list.push('detect_good') if self.detect_good
    list.push('sanctuary') if self.sanctuary
    list.push('faerie_fire') if self.faerie_fire
    list.push('infrared') if self.infrared
    list.push('curse') if self.curse
    list.push('no_steal') if self.no_steal
    list.push('poison') if self.poison
    list.push('protect_from_evil') if self.protect_from_evil
    list.push('protect_from_good') if self.protect_from_good
    list.push('sneak') if self.sneak
    list.push('hide') if self.hide
    list.push('sleep') if self.sleep
    list.push('charm') if self.charm
    list.push('flying') if self.flying
    list.push('passdoor') if self.passdoor
    list.push('no_trace') if self.no_trace
    list.push('no_sleep') if self.no_sleep
    list.push('no_summon') if self.no_summon
    list.push('no_charm') if self.no_charm
    list.push('improved_invis') if self.improved_invis
    return list.to_sentence.humanize.titleize.gsub(/And/,'and')
  end

  def languages_list
    list = Array.new
    list.push('common') if self.common
    list.push('dwarven') if self.dwarven
    list.push('elven') if self.elven
    list.push('gnomish') if self.gnomish
    list.push('halfling') if self.halfling
    list.push('aarakocra') if self.aarakocra
    list.push('giant') if self.giant
    list.push('minotaur') if self.minotaur
    list.push('ogre') if self.ogre
    list.push('thoras') if self.thoras
    list.push('goblin') if self.goblin
    list.push('drow') if self.drow
    list.push('kobold') if self.kobold
    list.push('orc') if self.orc
    list.push('troll') if self.troll
    list.push('sahaguin') if self.sahaguin
    list.push('god') if self.god
    if list.count < 1
        return 'none'
    else
        return list.to_sentence.humanize.titleize.gsub(/And/,'and')
    end
  end

  def language_word
    word = lang_from_num(self.lang_spoken)
    return word.downcase
  end

  def my_area
    return self.area
  end

end

def lang_from_num(i)
  lang = nil
  lang = 'NONE'      if i == 0
  lang = 'COMMON'    if i == 1
  lang = 'DWARVEN'   if i == 2
  lang = 'ELVEN'     if i == 4
  lang = 'GNOMISH'   if i == 8
  lang = 'HALFLING'  if i == 16
  lang = 'AARAKOCRA' if i == 32
  lang = 'GIANT'     if i == 64
  lang = 'MINOTAUR'  if i == 128
  lang = 'OGRE'      if i == 256
  lang = 'THORAS'    if i == 512
  lang = 'GOBLIN'    if i == 1024
  lang = 'DROW'      if i == 2048
  lang = 'KOBOLD'    if i == 4096
  lang = 'ORC'       if i == 8192
  lang = 'TROLL'     if i == 16384
  lang = 'SAHAGUIN'  if i == 32768
  lang = 'GOD'       if i == 65535
  return lang.upcase
end