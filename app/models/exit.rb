class TrapExitValidator < ActiveModel::Validator
  def validate(record)
    if !record.dir_type_combo_ok? # if a bad combo
      record.errors[:base] << "Trap type exits must be combined with down exits."
    end
  end
end

class Exit < ActiveRecord::Base
  belongs_to :room
  
  validates :direction, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   less_than_or_equal_to: 5,
                                  },
                   uniqueness:   { scope: :room,
                                   message: "No duplicate exit directions allowed." }
  validates :exittype, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: -1,
                                   less_than_or_equal_to: 4,
                                  }
  validates :keyvnum, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: -1,
                                  }
  validates :exitto, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: -1,
                                  }

  validates_with TrapExitValidator

  def dir_type_combo_ok?
    if ((self.exittype == 3) and !(self.direction == 5))  # is a trap, but not a down exit
      return false
    else
      return true
    end
  end


  def destination_exists?
    if Room.exists?(:vnum => self.exitto) 
      return true
    else
      return false
    end
  end
  
  def direction_word
    return num_to_dir(self.direction)
  end
  
  def exitto_formal
    if self.exitto > self.room.area.vnum_qty
      return self.exitto
    else
      return (self.room.area.area_number * 100) + self.exitto
    end
  end
  
  before_create :default_values
  def default_values
    self.exittype ||= 0
    self.keyvnum ||= 0
  end

end

  def num_to_dir(i)
    $word = nil
    $word = 'North' if i == 0
    $word = 'East' if i == 1
    $word = 'South' if i == 2
    $word = 'West' if i == 3
    $word = 'Up' if i == 4
    $word = 'Down' if i == 5
    return $word
  end