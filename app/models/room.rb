class Room < ActiveRecord::Base
  belongs_to :area
  has_many :rxdescs, dependent: :destroy
  has_many :exits, dependent: :destroy
  
  include Bitfields
  bitfield :room_flags, 1 => :dark, 2 => :no_sleep, 4 => :no_mob, 8 => :indoors, 32 => :foggy, 512 => :private_room, 1024 => :peaceful, 2048 => :solitary, 8192 => :no_recall, 16384 => :no_steal, 32768 => :notrans, 65536 => :no_spell, 262144 => :no_fly, 1048576 => :fly_ok, 2097152 => :no_quest, 4194304 => :no_item, 8388608 => :no_vnum

  validates :vnum, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   :less_than => :max_vnum,
                                   message: "Can't exceed max allowable vnum."
                                  },
                   uniqueness:   { scope: :area,
                                   message: "No duplicate vnums allowed." }

# validates :baggage, :numericality => { :less_than => :max_vnum }, :presence => true 


    
  validates :name, length: { in: 4..75 }
  validates :description, length: { minimum: 4 }
  validates :terrain, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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

  def destinations_exist?
    $exits_exist = true
    self.exits.each do |exit|
      if !exit.destination_exists?
        $exits_exist = false
      end
    end
    return $exits_exist
  end
  
  def exit_dir_exists?(i)
    $dir_exists = false
    self.exits.each do |exit|
      if exit.direction == i
        $dir_exists = true
      end
    end
    return $dir_exists
  end
  
  def vnum_and_name
    return  format("%03d",self.vnum) + " " + self.name
  end

end