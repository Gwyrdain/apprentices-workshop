class Obj < ActiveRecord::Base
  belongs_to :area
#  has_many :oxdescs, dependent: :destroy
#  has_many :applies, dependent: :destroy

  include Bitfields

  bitfield :wear_flags, 
                    2**0 =>  :takeable,      # Dec:          1 / Hex:         1
                    2**1 =>  :finger,        # Dec:          2 / Hex:         2
                    2**2 =>  :neck,          # Dec:          4 / Hex:         4
                    2**3 =>  :body,          # Dec:          8 / Hex:         8
                    2**4 =>  :head,          # Dec:         16 / Hex:        10
                    2**5 =>  :legs,          # Dec:         32 / Hex:        20
                    2**6 =>  :feet,          # Dec:         64 / Hex:        40
                    2**7 =>  :hands,         # Dec:        128 / Hex:        80
                    2**8 =>  :arms,          # Dec:        256 / Hex:       100
                    2**9 =>  :shield,        # Dec:        512 / Hex:       200
                    2**10 => :about,         # Dec:       1024 / Hex:       400
                    2**11 => :waist,         # Dec:       2048 / Hex:       800
                    2**12 => :wrist,         # Dec:       4096 / Hex:      1000
                    2**13 => :wield,         # Dec:       8192 / Hex:      2000
                    2**14 => :hold,          # Dec:      16384 / Hex:      4000
                    2**15 => :decoration     # Dec:      32768 / Hex:      8000

  bitfield :extra_flags, 
                    2**0 =>  :glow,          # Dec:          1 / Hex:         1
                    2**1 =>  :hum,           # Dec:          2 / Hex:         2
#                   2**2 =>  :flag,          # Dec:          4 / Hex:         4
#                   2**3 =>  :flag,          # Dec:          8 / Hex:         8
                    2**4 =>  :evil,          # Dec:         16 / Hex:        10
                    2**5 =>  :invis,         # Dec:         32 / Hex:        20
                    2**6 =>  :magic,         # Dec:         64 / Hex:        40
                    2**7 =>  :nodrop,        # Dec:        128 / Hex:        80
#                   2**8 =>  :flag,          # Dec:        256 / Hex:       100
                    2**9 =>  :anti_good,     # Dec:        512 / Hex:       200
                    2**10 => :anti_evil,     # Dec:       1024 / Hex:       400
                    2**11 => :anti_neutral,  # Dec:       2048 / Hex:       800
                    2**12 => :noremove,      # Dec:       4096 / Hex:      1000
                    2**13 => :inventory,     # Dec:       8192 / Hex:      2000
                    2**14 => :metallic,      # Dec:      16384 / Hex:      4000
                    2**15 => :good,          # Dec:      32768 / Hex:      8000
#                   2**16 => :flag,          # Dec:      65536 / Hex:     10000
                    2**17 => :not_purgable,  # Dec:     131072 / Hex:     20000
                    2**18 => :flammable,     # Dec:     262144 / Hex:     40000
                    2**19 => :two_handed,    # Dec:     524288 / Hex:     80000
#                   2**20 => :flag,          # Dec:    1048576 / Hex:    100000
                    2**21 => :use_cost,      # Dec:    2097152 / Hex:    200000
#                   2**22 => :flag,          # Dec:    4194304 / Hex:    400000
#                   2**23 => :flag,          # Dec:    8388608 / Hex:    800000
#                   2**24 => :flag,          # Dec:   16777216 / Hex:   1000000
                    2**25 => :anti_unalign,  # Dec:   33554432 / Hex:   2000000
#                   2**26 => :flag,          # Dec:   67108864 / Hex:   4000000
#                   2**27 => :flag,          # Dec:  134217728 / Hex:   8000000
                    2**28 => :neutral,        # Dec:  268435456 / Hex:  10000000
                    2**29 => :no_hoard,      # Dec:  536870912 / Hex:  20000000
                    2**30 => :masked        # Dec: 1073741824 / Hex:  40000000
#                   2**31 => :flag,          # Dec: 2147483648 / Hex:  80000000
#                   2**32 => :flag           # Dec: 4294967296 / Hex: 100000000

  bitfield :misc_flags, 
                    2**0 =>  :flammable2,          # Dec:          1 / Hex:         1
                    2**1 =>  :metallic2,           # Dec:          2 / Hex:         2
                    2**2 =>  :two_handed2,         # Dec:          4 / Hex:         4
                    2**3 =>  :underwater_breath    # Dec:          8 / Hex:         8

  validates :vnum, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   :less_than => :max_vnum,
                                   message: "Can't exceed max allowable vnum."
                                  },
                   uniqueness:   { scope: :area,
                                   message: "No duplicate vnums allowed." }
  validates :keywords, length: { in: 4..75 }
  validates :sdesc, length: { in: 4..75 }
  validates :ldesc, length: { minimum: 4 }
  validates :object_type, numericality: { only_integer: true, greater_than: 0 }
  validates :v0, numericality: { only_integer: true, greater_than: -2 }
  validates :v1, numericality: { only_integer: true, greater_than: -2 }
  validates :v2, numericality: { only_integer: true, greater_than: -2 }
  validates :v3, numericality: { only_integer: true, greater_than: -2 }
  validates :wear_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :extra_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :misc_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :default_values
  def default_values
    self.v0 ||= 0
    self.v1 ||= 0
    self.v2 ||= 0
    self.v3 ||= 0
    self.extra_flags ||= 0
    self.wear_flags ||= 1
    self.misc_flags ||= 0
    self.weight ||= 0
    self.cost ||= 0
  end

  def max_vnum
    area.vnum_qty
  end
  
  def formal_vnum
    (area.area_number * 100) + self.vnum
  end


end
