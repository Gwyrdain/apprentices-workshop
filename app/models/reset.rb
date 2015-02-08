class Reset < ActiveRecord::Base
  belongs_to :area
  
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

  def description
    $desc = nil
    $desc = "Load '" + Mobile.find(self.val_2).sdesc + "' at '" + Room.find(self.val_4).name + "'" if self.reset_type == 'M'
    $desc = "Load '" + Mobile.find(self.val_2).sdesc + "' at '" + Room.find(self.val_4).name + "'" if self.reset_type == 'Q'
    $desc = "Load '" + Obj.find(self.val_2).sdesc + "' at '" + Room.find(self.val_4).name + "'" if self.reset_type == 'O'
    $desc = "Set " + num_to_dir(self.val_3).downcase + " door at '" + Room.find(self.val_2).name + "' to " + door_state(self.val_4) if self.reset_type == 'D'
    $desc = "Randomize " + num_to_exits(self.val_3) + " exits at '" + Room.find(self.val_2).name + "'" if self.reset_type == 'R'
    return $desc
  end
  
  def desc_brief
    $desc = nil
    $desc = "MOBILE" if self.reset_type == 'M'
    $desc = "QUEST MOBILE" if self.reset_type == 'Q'
    $desc = "OBJECT" if self.reset_type == 'O'
    $desc = "DOOR" if self.reset_type == 'D'
    $desc = "RANDOMIZE" if self.reset_type == 'R'
    return $desc
  end
  
  def output
    $output = ''
    
    if ( self.reset_type == 'M' or self.reset_type == 'Q' )
      $output = self.reset_type + ' ' + self.val_1.to_s + ' ' + Mobile.find(self.val_2).formal_vnum.to_s
      $output = $output + ' ' + self.val_3.to_s + ' ' + Room.find(self.val_4).formal_vnum.to_s + " * "
    end
    if self.reset_type == 'O'
      $output = self.reset_type + ' ' + self.val_1.to_s + ' ' + Obj.find(self.val_2).formal_vnum.to_s
      $output = $output + ' ' + self.val_3.to_s + ' ' + Room.find(self.val_4).formal_vnum.to_s + " * "
    end
    if self.reset_type == 'D'
      $output = self.reset_type + ' ' + self.val_1.to_s + ' ' + Room.find(self.val_2).formal_vnum.to_s
      $output = $output + ' ' + self.val_3.to_s + ' ' + self.val_4.to_s + " * "
    end
    if self.reset_type == 'R'
      $output = self.reset_type + ' ' + self.val_1.to_s + ' ' + Room.find(self.val_2).formal_vnum.to_s
      $output = $output + ' ' + self.val_3.to_s + " * "
    end
    
    $output = $output + " " * ( 25 - $output.length )
    $output = $output + self.description    
    return $output
  end
  
end
