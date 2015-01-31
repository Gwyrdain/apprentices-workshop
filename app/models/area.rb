class Area < ActiveRecord::Base
  belongs_to :user
  has_many :helps, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :objs, dependent: :destroy
  
  include Bitfields
  bitfield  :flags, 2**0 => :manmade,  # Hex 1
                    2**1 => :city,     # Hex 2
                    2**2 => :forest,   # Hex 4
                    2**3 => :limited,  # Hex 8
                    2**4 => :aerial,   # Hex 10
                    2**5 => :reserved, # Hex 20
                    2**6 => :arena,    # Hex 40
                    2**7 => :quest,    # Hex 80
                    2**8 => :novnum    # Hex 100
                    
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
  validates :author, length: { in: 1..8 }
  validates :difficulty, length: { is: 5 }
  validates :vnum_qty, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :default_terrain, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :area_number,  numericality: { only_integer: true, greater_than: 0 },
                                           uniqueness:   { message: "Area number already in use." }

  before_create :default_values
  def default_values
    self.flags ||= 0
    self.vnum_qty ||= 100
    self.default_terrain ||= 0
    self.default_room_flags ||= 0
    return true
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
  
  def flags_as_hex
    #return self.flags.to_s(16).upper ... trying new
    return "%X" % self.flags
    
  end
  
end
