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
  validates :description, length: { minimum: 4 }
  validates :keywords, length: { in: 4..75 }
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
  validates :name, length: { in: 4..75 }
  
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
    $word = ''
    $word = 'north' if self.direction == 0
    $word = 'east' if self.direction == 1
    $word = 'south' if self.direction == 2
    $word = 'west' if self.direction == 3
    $word = 'up' if self.direction == 4
    $word = 'down' if self.direction == 5
    return $word
  end

end
