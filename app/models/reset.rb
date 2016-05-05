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

  def comment( verbose = false )
    $comment = nil

    if ( self.reset_type == 'M' || self.reset_type == 'Q' )
      $comment = "Load '#{mobile_info(self.val_2, 'sdesc')}'#{ verbose ? ' (' + mobile_info(self.val_2, 'formal_vnum') + ')' : ''} " <<
                   "at '#{  room_info(self.val_4, 'name' )}'#{ verbose ? ' (' +   room_info(self.val_4, 'formal_vnum') + ')' : ''}" <<
                   "#{ verbose ? ' with LIMIT ' + self.val_3.to_s : ''}"
    end

    if self.reset_type == 'O'
      $comment = "Load '#{ obj_info(self.val_2, 'sdesc', self.area)}'#{ verbose ? ' (' +  obj_info(self.val_2, 'formal_vnum', self.area) + ')' : ''} " <<
                   "at '#{room_info(self.val_4, 'name')            }'#{ verbose ? ' (' + room_info(self.val_4, 'formal_vnum') + ')' : ''}"
    end

    if ( self.reset_type == 'I' || self.reset_type == 'P' )

      self.reset_type == 'I' ? $verb = 'Insert' : $verb = 'Put'

      if self.parent
        $comment = "#{$verb} '#{ obj_info(self.val_2, 'sdesc', self.area)       }'#{ verbose ? ' (' + obj_info(self.val_2, 'formal_vnum', self.area) + ')' : ''} " <<
                       "into '#{ obj_info(self.parent.val_2, 'sdesc', self.area)}'#{ verbose ? ' (' + obj_info(self.parent.val_2, 'formal_vnum', self.area) + ')' : ''}"
      else
        $comment = "#{$verb} '#{ obj_info(self.val_2, 'sdesc', self.area)       }'#{ verbose ? ' (' + obj_info(self.val_2, 'formal_vnum', self.area) + ')' : ''} " <<
                       "into 'MISSING PARENT'"
      end
    end

    if self.reset_type == 'D'
      $comment = "Set #{self.reset_door_direction} door at '#{room_info(self.val_2, 'name')}' #{ verbose ? ' (' + room_info(self.val_2, 'formal_vnum') + ')' : ''} to #{door_state(self.val_4)}"
    end

    if self.reset_type == 'R'
      $comment = "Randomize any #{num_to_exits(self.val_3)} exits at '#{room_info(self.val_2, 'name')}'#{ verbose ? ' (' + room_info(self.val_2, 'formal_vnum') + ')' : ''}"
    end

    return $comment
  end

  def output
    $output = ''

    if ( self.reset_type == 'M' or self.reset_type == 'Q' )
      $output = self.reset_type + ' ' + '0' + ' ' + mobile_info(self.val_2, 'formal_vnum')
      $output = $output + ' ' + self.val_3.to_s + ' ' + room_info(self.val_4, 'formal_vnum') + " * "
    end
    if self.reset_type == 'O'
      $output = self.reset_type + ' ' + '0' + ' ' + obj_info(self.val_2, 'formal_vnum', self.area)
      $output = $output + ' ' + self.val_3.to_s + ' ' + room_info(self.val_4, 'formal_vnum') + " * "
    end
    if self.reset_type == 'I'
      $output = self.reset_type + ' ' + '0' + ' ' + obj_info(self.val_2, 'formal_vnum', self.area)
      $output = $output + ' ' + self.val_3.to_s + ' ' + obj_info(self.parent.val_2, 'formal_vnum', self.area) + " * "
    end
    if self.reset_type == 'P'
      $output = self.reset_type + ' ' + '0' + ' ' + obj_info(self.val_2, 'formal_vnum', self.area)
      $output = $output + ' ' + self.val_3.to_s + ' ' + obj_info(self.parent.val_2, 'formal_vnum', self.area) + " * "
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
    $desc = "PUT" if self.reset_type == 'P'
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

  def first_ancestor
    ancestor = nil

    if self.parent
      ancestor = self.parent.first_ancestor if self.parent_type == 'reset'
      ancestor = self.parent.parent.first_ancestor if self.parent_type == 'sub_reset'
    else
        ancestor = self
    end
    return ancestor
  end

  def count_dependents
    $count = 0
    $count = $count + self.sub_resets.count
    $count = $count + self.area.resets.where(parent_id: self.id).count
    return $count
  end

  def dependent_resets
    return self.area.resets.where(parent_id: self.id)
  end

  def my_area
    return self.area
  end

  def is_container
    if (( self.reset_type == 'O' || self.reset_type == 'I' || self.reset_type == 'P' ) &&
          self.area.objs.exists?(:id => self.obj_id) && Obj.find(self.obj_id).is_container )
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

