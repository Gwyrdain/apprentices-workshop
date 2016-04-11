class Reset < ActiveRecord::Base
  belongs_to :area
  
  has_many :sub_resets, dependent: :destroy
  
  validates :val_1, numericality: { only_integer: true, greater_than: -1 }
  validates :val_2, numericality: { only_integer: true, greater_than: -1 }
  validates :val_3, numericality: { only_integer: true, greater_than: -1 }
  validates :val_4, numericality: { only_integer: true, greater_than: -1 }
  
  before_create :default_values
  def default_values
    self.reset_type ||= 0
    self.val_1 ||= 0
    self.val_2 ||= 0
    self.val_3 ||= 0
    self.val_4 ||= 0
  end

  def comment
    $comment = nil
    $comment = "Load '" + mobile_info(self.val_2, 'sdesc') + "' at '" + room_info(self.val_4, 'name') + "'" if ( self.reset_type == 'M' || self.reset_type == 'Q' )
    $comment = "Load '" + obj_info(self.val_2, 'sdesc') + "' at '" + room_info(self.val_4, 'name') + "'" if self.reset_type == 'O'
    
    if self.reset_type == 'I'
      if self.parent
        $comment = "Insert '" + obj_info(self.val_2, 'sdesc') + "' into '" + obj_info(self.parent.val_2, 'sdesc') + "'"
      else
        $comment = "Insert '" + obj_info(self.val_2, 'sdesc') + "' into '" + 'MISSING PARENT' + "'"
      end
    end
  
    $comment = "Set " + self.reset_door_direction + " door at '" + room_info(self.val_2, 'name') + "' to " + door_state(self.val_4) if self.reset_type == 'D'
    $comment = "Randomize any " + num_to_exits(self.val_3) + " exits at '" + room_info(self.val_2, 'name') + "'" if self.reset_type == 'R'
    return $comment
  end
  
  def output
    $output = ''
    
    if ( self.reset_type == 'M' or self.reset_type == 'Q' )
      $output = self.reset_type + ' ' + '0' + ' ' + mobile_info(self.val_2, 'formal_vnum')
      $output = $output + ' ' + self.val_3.to_s + ' ' + room_info(self.val_4, 'formal_vnum') + " * "
    end
    if self.reset_type == 'O'
      $output = self.reset_type + ' ' + '0' + ' ' + obj_info(self.val_2, 'formal_vnum')
      $output = $output + ' ' + self.val_3.to_s + ' ' + room_info(self.val_4, 'formal_vnum') + " * "
    end
    if self.reset_type == 'I'
      $output = self.reset_type + ' ' + '0' + ' ' + obj_info(self.val_2, 'formal_vnum')
      $output = $output + ' ' + self.val_3.to_s + ' ' + obj_info(self.parent.val_2, 'formal_vnum') + " * "
    end
    if self.reset_type == 'D'
      $output = self.reset_type + ' ' + '0' + ' ' + room_info(self.val_2, 'formal_vnum')
      $output = $output + ' ' + self.val_3.to_s + ' ' + self.val_4.to_s + " * "
    end
    if self.reset_type == 'R'
      $output = self.reset_type + ' ' + '0' + ' ' + room_info(self.val_2, 'formal_vnum')
      $output = $output + ' ' + self.val_3.to_s + " * "
    end
    
    $output = $output + " " * ( 25 - $output.length )
    $output = $output + self.comment    
    return $output
  end
  
  def desc_brief
    $desc = nil
    $desc = "MOBILE" if self.reset_type == 'M'
    $desc = "QUEST MOBILE" if self.reset_type == 'Q'
    $desc = "OBJECT" if self.reset_type == 'O'
    $desc = "INSERT" if self.reset_type == 'I'
    $desc = "DOOR" if self.reset_type == 'D'
    $desc = "RANDOMIZE" if self.reset_type == 'R'
    return $desc
  end
  
  def mobile_id
    return self.val_2
  end
  
  def obj_id
    return self.val_2
  end

  def reset_door_direction
    if ( self.area.rooms.exists?(:id => self.val_2) &&
         Room.find(self.val_2).exits.exists?(:direction => self.val_3) )
         
      if Room.find(self.val_2).exits.where(:direction => self.val_3).first.has_door? 
        return num_to_dir(self.val_3).downcase
      else
        return '!!!NO ' + num_to_dir(self.val_3).upcase + ' DOOR FOUND!!!'
      end
    else
      return 'UNKNOWN'
    end
  end
  
  def parent
    $parent = nil
    
    if (self.parent_type == 'reset') && (Reset.exists?(:id => self.parent_id))
      $parent =  Reset.find(self.parent_id)
    end
    
    if (self.parent_type == 'sub_reset') && (SubReset.exists?(:id => self.parent_id))
      $parent = SubReset.find(self.parent_id)
    end
      
    return $parent
  end

end

