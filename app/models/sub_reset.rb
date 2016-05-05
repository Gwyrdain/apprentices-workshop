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
  validates :val_4, uniqueness: { scope: :reset, message: "No duplicate wear locations allowed." }, if: :equip_reset?



  validates_with SubResetValidator

  before_create :default_values
  def default_values
    self.reset_type ||= 0
    self.val_1 ||= 0
    self.val_2 ||= 0
    self.val_3 ||= 0
    self.val_4 ||= 0
  end

  def equip_reset?
    self.reset_type == 'E' ? true : false
  end

  def comment( verbose = false )
    $comment = ''
    $obj_sdesc = obj_info(self.val_2, 'sdesc', self.reset.area)
    verbose ? $obj_vnum = " (" + obj_info(self.val_2, 'formal_vnum', self.reset.area) + ")" : $obj_vnum = ''

    if (self.reset_type == 'E' || self.reset_type == 'G' || self.reset_type == 'C' || self.reset_type == 'F' )
      $target_sdesc = mobile_info(self.reset.val_2, 'sdesc')
      verbose ? $target_vnum = " (" + mobile_info(self.reset.val_2, 'formal_vnum') + ")" : $target_vnum = ''
    end

    if self.reset_type == 'P'
      $target_sdesc = obj_info(self.reset.val_2, 'sdesc', self.reset.area)
      verbose ? $target_vnum = " (" + obj_info(self.reset.val_2, 'formal_vnum', self.reset.area) + ")" : $target_vnum = ''
    end

    $comment = "Equip '#{$target_sdesc}'#{$target_vnum} with '#{$obj_sdesc}'#{$obj_vnum} as #{self.wear_loc_word}" if self.reset_type == 'E'
    $comment = "Give '#{$target_sdesc}'#{$target_vnum} '#{$obj_sdesc}'#{$obj_vnum}" if self.reset_type == 'G'
    $comment = "Put '#{$obj_sdesc}'#{$obj_vnum} into '#{$target_sdesc}'#{$target_vnum}" if self.reset_type == 'P'
    $comment = "Give '#{$target_sdesc}'#{$target_vnum} a random #{random_type_word(self.val_2)}" if self.reset_type == 'C'
    $comment = "Equip '#{$target_sdesc}'#{$target_vnum} with a random #{random_type_word(self.val_2)}" if self.reset_type == 'F'
    return $comment
  end

  def output
    $output = "#{self.reset_type} 0 #{obj_info(self.val_2, 'formal_vnum', self.reset.area)} 100"

    if ( self.reset_type == 'C' || self.reset_type == 'F' )
      $output = "#{self.reset_type} 0 #{self.val_2} 0 0"
    end

    if self.reset_type == 'E'
      $output = $output << " #{self.val_4}"
    end
    if self.reset_type == 'P'
      $output = $output << " #{obj_info(self.reset.val_2, 'formal_vnum', self.reset.area)}"
    end

    $output = $output << " *" << " " * ( 25 - $output.length ) << self.comment
    return $output
  end

  def desc_brief
    $desc = nil
    $desc = "EQUIP" if self.reset_type == 'E'
    $desc = "GIVE" if self.reset_type == 'G'
    $desc = "PUT" if self.reset_type == 'P'
    $desc = "EQUIP RANDOM" if self.reset_type == 'F'
    $desc = "GIVE RANDOM" if self.reset_type == 'C'
    return $desc
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

  def obj_id
    return self.val_2
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

  def equip_view_prefix
    $prefix = '<used as light' if self.val_4 == 0
    $prefix = '<worn on finger' if self.val_4 == 1 || self.val_4 == 2
    $prefix = '<worn around neck' if self.val_4 == 3 || self.val_4 == 4
    $prefix = '<worn on body' if self.val_4 == 5
    $prefix = '<worn on head' if self.val_4 == 6
    $prefix = '<worn on legs' if self.val_4 == 7
    $prefix = '<worn on feet' if self.val_4 == 8
    $prefix = '<worn on hands' if self.val_4 == 9
    $prefix = '<worn on arms' if self.val_4 == 10
    $prefix = '<worn as shield' if self.val_4 == 11
    $prefix = '<worn about body' if self.val_4 == 12
    $prefix = '<worn about waist' if self.val_4 == 13
    $prefix = '<worn around wrist' if self.val_4 == 14 || self.val_4 == 15
    $prefix = '<wielded' if self.val_4 == 16
    $prefix = '<held' if self.val_4 == 17
    $prefix = '<worn with pride' if self.val_4 == 18
    $prefix = $prefix << ">" << " " * ( 21 - $prefix.length )
    return $prefix
  end

  def count_dependents
    $count = 0
    $count = $count + self.reset.area.resets.where(parent_id: self.id).count
    return $count
  end

  def dependent_resets
    return self.reset.area.resets.where(parent_id: self.id)
  end

  def parent
    return self.reset
  end

  def first_ancestor
    return self.parent.first_ancestor
  end

  def my_area
    return self.reset.area
  end

  def is_container
    if (( self.reset_type == 'E' || self.reset_type == 'G' ) &&
          self.reset.area.objs.exists?(:id => self.obj_id) && Obj.find(self.obj_id).is_container )
      return true
    else
      return false
    end
  end

  def container_capacity
    if self.is_container
      $container = Obj.find(self.obj_id)
      # capacity value less container weight
      return ( $container.v0 - $container.weight )
    else
      return 0
    end
  end

  def container_weight_held
    if self.is_container
      $weight_held = 0
      dependent_resets.each do |dependent_reset|
        if dependent_reset.is_container
          $weight_held = $weight_held + dependent_reset.container_filled_weight
        else
          $weight_held = $weight_held + dependent_reset.object_weight
        end
      end
      return $weight_held
    else
      return 0
    end
  end

  def object_weight
    $object = Obj.find(self.obj_id)
    return $object.weight
  end

  def container_filled_weight
    return (self.container_weight_held + self.object_weight)
  end

end