class SubReset < ActiveRecord::Base
  belongs_to :reset
  
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
    $desc = nil
    $desc = "Equip '" + self.reset.load_mob_name + "' with '" + self.load_obj_name + "'" if self.reset_type == 'E'
    $desc = "Give '" + self.reset.load_mob_name + "' '" + self.load_obj_name + "'" if self.reset_type == 'G'
    $desc = "Put '" + self.load_obj_name + "' into '" + self.reset.load_obj_name + "'" if self.reset_type == 'P'
    return $desc
  end
  
  def output
    $output = ''
    
    if self.reset_type == 'E'
      $output = self.reset_type + ' ' + self.val_1.to_s + ' ' + self.load_obj_vnum
      $output = $output + ' ' + self.val_3.to_s + ' ' + self.load_obj_wear_loc + " * "
    end
    if self.reset_type == 'G'
      $output = self.reset_type + ' ' + self.val_1.to_s + ' ' + self.load_obj_vnum
      $output = $output + ' ' + self.val_3.to_s + " * "
    end
    if self.reset_type == 'P'
      $output = self.reset_type + ' ' + self.val_1.to_s + ' ' + self.load_obj_vnum
      $output = $output + ' ' + self.val_3.to_s + ' ' + self.reset.load_obj_vnum + " * "
    end
    
    $output = $output + " " * ( 25 - $output.length )
    $output = $output + self.comment    
    return $output
  end
  
  def desc_brief
    $desc = nil
    $desc = "EQUIP" if self.reset_type == 'E'
    $desc = "GIVE" if self.reset_type == 'G'
    $desc = "PUT" if self.reset_type == 'P'
    return $desc
  end
  
  def load_obj_name
    if self.area.objs.exists?(:id => self.val_2)
      return Obj.find(self.val_2).sdesc
    else
      return 'UNKNOWN'
    end
  end

  def load_obj_vnum
    if self.area.objs.exists?(:id => self.val_2)
      return Obj.find(self.val_2).formal_vnum.to_s
    else
      return 'UNKNOWN'
    end
  end
  
  def load_obj_wear_loc
    if self.area.objs.exists?(:id => self.val_2)
      return Obj.find(self.val_2).formal_vnum.to_s
    else
      return 'UNKNOWN'
    end
  end

end