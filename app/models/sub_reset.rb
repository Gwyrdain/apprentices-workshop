class SubResetValidator < ActiveModel::Validator
  def validate(record)
    
    if !record.wear_loc_ok? # if a combination of obj and wear location
      record.errors[:base] << "Wear location not suitable for the given object."
    end

  end
end

class SubReset < ActiveRecord::Base
  belongs_to :reset
  
  validates :val_1, numericality: { only_integer: true, greater_than: -1 }
  validates :val_2, numericality: { only_integer: true, greater_than: -1 }
  validates :val_3, numericality: { only_integer: true, greater_than: -1 }
  validates :val_4, numericality: { only_integer: true, greater_than: -1 }
  
  validates_with SubResetValidator
  
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
    $desc = "Equip '" + self.reset.load_mob_name + "' with '" + self.load_obj_name + "' as " + self.wear_loc_word if self.reset_type == 'E'
    $desc = "Give '" + self.reset.load_mob_name + "' '" + self.load_obj_name + "'" if self.reset_type == 'G'
    $desc = "Put '" + self.load_obj_name + "' into '" + self.reset.load_obj_name + "'" if self.reset_type == 'P'
    return $desc
  end
  
  def output
    $output = ''

    if self.reset_type == 'E'
      $output = self.reset_type + ' 0 ' + self.load_obj_vnum + ' 100 ' + self.val_4.to_s + ' * '
    end
    if self.reset_type == 'G'
      $output = self.reset_type + ' 0 ' + self.load_obj_vnum + ' 100 * '
    end
    if self.reset_type == 'P'
      $output = self.reset_type + ' 0 ' + self.load_obj_vnum + ' 100 ' + self.reset.load_obj_vnum + ' * '
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
    if self.reset.area.objs.exists?(:id => self.val_2)
      return Obj.find(self.val_2).sdesc
    else
      return 'UNKNOWN'
    end
  end

  def load_obj_vnum
    if self.reset.area.objs.exists?(:id => self.val_2)
      return Obj.find(self.val_2).formal_vnum.to_s
    else
      return 'UNKNOWN'
    end
  end
  
  def load_obj_wear_loc
    if self.reset.area.objs.exists?(:id => self.val_2)
      return 'PutLocationHere' # Obj.find(self.val_2).formal_vnum.to_s
    else
      return 'UNKNOWN'
    end
  end
  
  def wear_loc_word
    $loc_word = nil
    $loc_word = 'LIGHT' if self.val_4 == 0
    $loc_word = 'LEFT FINGER' if self.val_4 == 1
    $loc_word = 'RIGHT FINGER' if self.val_4 == 2
    $loc_word = '1ST NECK' if self.val_4 == 3
    $loc_word = '2ND NECK' if self.val_4 == 4
    $loc_word = 'BODY' if self.val_4 == 5
    $loc_word = 'HEAD' if self.val_4 == 6
    $loc_word = 'LEGS' if self.val_4 == 7
    $loc_word = 'FEET' if self.val_4 == 8
    $loc_word = 'HANDS' if self.val_4 == 9
    $loc_word = 'ARMS' if self.val_4 == 10
    $loc_word = 'SHIELD' if self.val_4 == 11
    $loc_word = 'ABOUT BODY' if self.val_4 == 12
    $loc_word = 'WAIST' if self.val_4 == 13
    $loc_word = 'LEFT WRIST' if self.val_4 == 14
    $loc_word = 'RIGHT WRIST' if self.val_4 == 15
    $loc_word = 'WIELD' if self.val_4 == 16
    $loc_word = 'HOLD' if self.val_4 == 17
    $loc_word = 'DECORATION' if self.val_4 == 18
    return $loc_word
  end

  def wear_loc_ok?
    i = true
    
    if self.reset_type == 'E'
      if self.reset.area.objs.exists?(:id => self.val_2) # be sure object exists
        $load_obj = Obj.find(self.val_2)
        
        if self.val_4 == 0 # LIGHT
          $load_obj.wear_flags < 2 ? i = true : i = false
        end
        
        if ( self.val_4 == 1 || self.val_4 == 2 ) # FINGER
          $load_obj.finger? ? i = true : i = false
        end
        
        if ( self.val_4 == 3 || self.val_4 == 4 ) # NECK
          $load_obj.neck? ? i = true : i = false
        end
        
        if self.val_4 == 5 # BODY
          $load_obj.body? ? i = true : i = false
        end
        
        if self.val_4 == 6 # HEAD
          $load_obj.head? ? i = true : i = false
        end
        
        if self.val_4 == 7 # LEGS
          $load_obj.legs? ? i = true : i = false
        end
        
        if self.val_4 == 8 # FEET
          $load_obj.feet? ? i = true : i = false
        end
        
        if self.val_4 == 9 # HANDS
          $load_obj.hands? ? i = true : i = false
        end
        
        if self.val_4 == 10 # ARMS
          $load_obj.arms? ? i = true : i = false
        end
        
        if self.val_4 == 11 # SHIELD
          $load_obj.shield? ? i = true : i = false
        end
        
        if self.val_4 == 12 # ABOUT
          $load_obj.about? ? i = true : i = false
        end
        
        if self.val_4 == 13 # WAIST
          $load_obj.waist? ? i = true : i = false
        end
        
        if ( self.val_4 == 14 || self.val_4 == 15 ) # WRIST
          $load_obj.wrist? ? i = true : i = false
        end
        
        if self.val_4 == 16 # WIELD
          $load_obj.wield? ? i = true : i = false
        end
        
        if self.val_4 == 17 # HOLD
          $load_obj.hold? ? i = true : i = false
        end
        
        if self.val_4 == 18 # DECORATION
          $load_obj.decoration? ? i = true : i = false
        end
        
      end
    end
    
    return i
  end
  
end