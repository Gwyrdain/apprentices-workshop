class Special < ActiveRecord::Base
  belongs_to :mobile
  
  validates :name, uniqueness: { scope: :mobile, message: "No duplicate specials of this type." }, unless: :allowable_duplicate
  validates :extended_value_1, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_2, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_3, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_4, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_5, numericality: { only_integer: true, greater_than: -2 }
  
  before_create :default_values
  def default_values
    self.special_type ||= 'M'
    self.name ||= ''
    self.extended_value_1 ||= -1
    self.extended_value_2 ||= -1
    self.extended_value_3 ||= -1
    self.extended_value_4 ||= -1
    self.extended_value_5 ||= -1
  end

  def output
    output = ''
    
    output = "#{self.special_type} #{self.mobile.formal_vnum} #{self.name}"
    
    if self.special_type == 'N'
      if self.name == 'spec_act_on_give'
        output = output << " #{obj_info(self.extended_value_1, 'formal_vnum', self.mobile.area)} #{self.extended_value_2}"
        output = output << " #{room_info(self.extended_value_3, 'formal_vnum')}" if self.extended_value_2 == 0
        output = output << " #{obj_info(self.extended_value_3, 'formal_vnum', self.mobile.area)}" if self.extended_value_2 == 1
        output = output << " -1 #{get_string_vnum(self.extended_value_5)}"
      end
      if self.name == 'spec_call_for_help'
        output = output << " #{self.extended_value_1} #{self.extended_value_2} -1 -1 -1"
      end
      if self.name == 'spec_mage_protector'
        output = output << " #{get_string_vnum(self.extended_value_1)} -1 -1 -1 -1"
      end
      if self.name == 'spec_timed_teleport'
        output = output << " #{self.extended_value_1} #{self.extended_value_2} -1 -1 -1"
      end
    end
    
    output = output << " * #{self.comment}"
    return output
  end
  
  def comment
    comment = "#{self.mobile.sdesc}"
    
    if self.name == 'spec_act_on_give'
      comment = comment << ": when given '#{obj_info(self.extended_value_1, 'sdesc', self.mobile.area)}',"
      comment = comment << " transfer PC to '#{room_info(self.extended_value_3, 'name')}'" if self.extended_value_2 == 0
      comment = comment << " give PC '#{obj_info(self.extended_value_3, 'sdesc', self.mobile.area)}'" if self.extended_value_2 == 1
    end
    if self.name == 'spec_call_for_help'
      comment = comment << ": call a #{self.helper_type} from #{self.helper_dist}"
    end
    if self.name == 'spec_timed_teleport'
      comment = comment << ": a 1 in #{2**self.extended_value_2} chance of teleporting at #{hour_from_num(self.extended_value_1)}"
    end

    return comment
  end

  def helper_type
    type = nil
    type = 'mob with spec_clark_kent' if self.extended_value_1 == 1
    type = 'mob with spec_superman' if self.extended_value_1 == 2
    return type
  end
  
  def helper_dist
    dist = nil
    dist = 'the whole world' if self.extended_value_2 == -1
    dist = 'the same room' if self.extended_value_2 == 0
    dist = 'the same area' if self.extended_value_2 == 0
    return dist
  end
  
  def allowable_duplicate
    allow = false
    allow = true if self.name == "spec_act_on_give"
    return allow
  end
  
  def my_area
    return self.mobile.area
  end

end
