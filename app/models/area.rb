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
                    
  bitfield :default_room_flags, 1 => :dark,
                                2 => :no_sleep,
                                4 => :no_mob, 
                                8 => :indoors, 
                                32 => :foggy, 
                                512 => :private_room, 
                                1024 => :peaceful, 
                                2048 => :solitary, 
                                8192 => :no_recall, 
                                16384 => :no_steal, 
                                32768 => :notrans, 
                                65536 => :no_spell, 
                                262144 => :no_fly, 
                                1048576 => :fly_ok, 
                                2097152 => :no_quest, 
                                4194304 => :no_item, 
                                8388608 => :no_vnum

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
  
  def flags_as_hex
    #return self.flags.to_s(16).upper ... trying new
    return "%X" % self.flags
    
  end
  
end
