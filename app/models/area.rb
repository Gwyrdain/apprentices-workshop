class Area < ActiveRecord::Base
    belongs_to :user
    has_many :helps
    has_many :rooms
    
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

    validates :name, length: { in: 1..20 }
    validates :author, length: { in: 1..8 }
    validates :difficulty, length: { is: 5 }
    validates :vnum_qty, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :default_values
  def default_values
    self.vnum_qty ||= 100
    self.flags ||= 0
    return true
  end
  
  def nextroomvnum
    $i = 0
    while Room.exists?(:vnum => $i)  do
        $i +=1
    end
    return $i
  end
  
  def flags_as_hex
    #return self.flags.to_s(16).upper ... trying new
    return "%X" % self.flags
    
  end
  
end
