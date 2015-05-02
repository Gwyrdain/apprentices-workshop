class ExitValidator < ActiveModel::Validator
  def validate(record)
    
    if !record.dir_type_combo_ok? # if a bad combo
      record.errors[:base] << "Trap type exits must be combined with down exits."
    end
    
    if (record.exittype == -1 and record.exit_room_id != -1)
      record.errors[:base] << "Look only exit directions cannot be combined with Local or External Exit Vnums."
    end

    if (record.exittype != -1 and record.exit_room_id == -1)
      record.errors[:base] << "Look only exit directions must be used if a Local or External Exit Vnum is not specified."
    end

  end
  
end

class Exit < ActiveRecord::Base
  belongs_to :room
  
  has_many :triggers, dependent: :destroy
  
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
                                  
  validates :exit_room_id, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: -2,
                                  }

  validates_with ExitValidator

  def dir_type_combo_ok?
    if ((self.exittype == 3) and !(self.direction == 5))  # is a trap, but not a down exit
      return false
    else
      return true
    end
  end

  def destination_exists?
    if ( Room.exists?(self.exit_room_id) && self.destination.area == self.room.area)
      return true
    else
      return false
    end
  end

  def destination
      return Room.find(self.exit_room_id)
  end
  
  def direction_word
    return num_to_dir(self.direction)
  end

  def type_desc
    $desc = 'nil'
    $desc = 'Look-only' if self.exittype == -1
    $desc = 'No door' if self.exittype == 0
    $desc = 'Door (pick/pass ok)' if self.exittype == 1
    $desc = 'Door (no pick/pass)' if self.exittype == 2
    $desc = 'Trap' if self.exittype == 3
    return $desc
  end
  
  def formal_key_vnum
    if self.is_key_external? == true || self.keyvnum == 0
      return self.keyvnum
    else
      return obj_info(self.keyvnum, 'formal_vnum')
    end
  end

  def is_key_external?
    if Obj.exists?(:id => self.keyvnum)
      $this_obj = Obj.find(self.keyvnum)
      if $this_obj.area == self.room.area
        return false
      else
        return true
      end
    else
      return true
    end
  end
  
  def formal_vnum
    if self.destination_exists?
      return self.destination.formal_vnum
    else
      return self.exit_room_id
    end
  end

  def is_bad?
    if (self.exit_room_id == -1 and self.exittype != -1)
      return true
    else
      return false
    end
  end


  def is_external?
    if ( self.exit_room_id == -1 || self.destination_exists? )
      return false
    else
      return true
    end
  end

  def is_loopback?
    if ( self.destination_exists? && self.destination.id == self.room.id )
      return true
    else
      return false
    end
  end

  def is_one_way?
    if ( self.destination_exists? && !self.is_loopback? )
      if self.destination.exits.where(:exit_room_id => self.room.id).first
        return false
      else
        return true
      end
    else
      return false
    end
  end
  
  def is_reciprocal?
    if (self.destination_exists? && !self.is_one_way? && !self.is_loopback?)
      if (self.destination.exits.where(:direction => opposite_dir(self.direction)).count > 0 && 
          self.destination.exits.where(:direction => opposite_dir(self.direction)).first.exit_room_id == self.room.id )
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  def reciprocal_door_mismatch?
    $result = false
    if self.is_reciprocal?
      $reciprocal_exit = self.destination.exits.where(:direction => opposite_dir(self.direction)).first
      if $reciprocal_exit.exittype != self.exittype
        $result = "mismatched exit types: #{self.type_desc} vs #{$reciprocal_exit.type_desc}"
      else
        if $reciprocal_exit.reset != self.reset
          $result = "mismatched reset types: #{self.reset_desc} vs #{$reciprocal_exit.reset_desc}"
        end
      end
    end
    return $result
  end
  

  def is_illogical?
    if (self.destination_exists? && !self.is_one_way? && !self.is_loopback?)
      if (self.destination.exits.where(:direction => opposite_dir(self.direction)).count > 0 && 
          self.destination.exits.where(:direction => opposite_dir(self.direction)).first.exit_room_id == self.room.id )
        return false
      else
        return true
      end
      return false
    end
  end
  
  def has_door?
    if ( self.exittype == 1 || self.exittype == 2 )
      return true
    else
      return false
    end
  end
  
  def reset_desc
    $desc = 'none'
    $desc = 'open' if self.reset == 0
    $desc = 'closed' if self.reset == 1
    $desc = 'closed & locked' if self.reset == 2
    return $desc
  end
  
  def reset_output
    $output = 'D 0 ' + self.room.formal_vnum.to_s + ' ' + self.direction.to_s + ' ' + self.reset.to_s + ' * '
    $output = $output + " " * ( 25 - $output.length )
    $output = $output + self.comment    
    return $output
  end

  def comment
    $desc = "Set " + self.direction_word.downcase + " door at '" + self.room.name + "' to " + self.reset_desc
  end
  
  def has_reset?
    i = false
    i = true if self.has_door? && self.reset == 0
    i = true if self.has_door? && self.reset == 1
    i = true if self.has_door? && self.reset == 2
    return i
  end

  before_create :default_values
  def default_values
    self.direction ||= 0
    self.description ||= ''
    self.keywords ||= ''
    self.exittype ||= -1
    self.keyvnum ||= 0
    self.exit_room_id ||= -1
    self.name ||= ''
  end

end

