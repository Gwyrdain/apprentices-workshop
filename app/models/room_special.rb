class RoomSpecial < ActiveRecord::Base
  belongs_to :room

  validates :room_id, uniqueness:  { scope: :room,
                                       message: "Only one room special function allowed per room." }
  validates :extended_value_1, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_2, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_3, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_4, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_5, numericality: { only_integer: true, greater_than: -2 }
  
  before_create :default_values
  def default_values
    self.room_special_type ||= 'D'
    self.name ||= ''
    self.extended_value_1 ||= -1
    self.extended_value_2 ||= -1
    self.extended_value_3 ||= -1
    self.extended_value_4 ||= -1
    self.extended_value_5 ||= -1
  end
  
  def comment
    comment = "#{self.room.name}"
    if self.name == 'spec_check_door_open'
      comment = comment << ": require min. #{num_to_attribute(self.extended_value_2)} of #{self.extended_value_3} for the #{num_to_dir(self.extended_value_1).downcase} exit"
    end
    return comment
  end
  
  def output
    output = "#{self.room_special_type} #{self.room.formal_vnum} #{self.name}"
    
    if self.room_special_type == 'E'
      output = output << " #{self.extended_value_1} #{self.extended_value_2} #{self.extended_value_3}"
      
      if self.name == 'spec_check_door_open'
        output = output << " #{get_string_vnum(self.extended_value_4)} #{get_string_vnum(self.extended_value_5)}"
      end
    end
    
    output = output << " * #{self.comment}"
    return output
  end

end
