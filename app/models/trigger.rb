class Trigger < ActiveRecord::Base
  belongs_to :exit

  validates :exit_id, uniqueness:  { scope: :exit,
                                       message: "Only one trigger allowed per exit." }
  validates :extended_value_1, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_2, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_3, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_4, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_5, numericality: { only_integer: true, greater_than: -2 }
  
  include Bitfields
  bitfield :extended_value_5, 
                2**0 =>  :bit_1,          # Dec:          1 / Hex:         1
                2**1 =>  :bit_2,          # Dec:          2 / Hex:         2
                2**2 =>  :bit_3,          # Dec:          4 / Hex:         4
                2**3 =>  :bit_4,          # Dec:          8 / Hex:         8
                2**4 =>  :bit_5           # Dec:         16 / Hex:        10
  
  
  before_create :default_values
  def default_values
    self.trigger_type ||= 'A'
    self.name ||= ''
    self.extended_value_1 ||= -1
    self.extended_value_2 ||= -1
    self.extended_value_3 ||= -1
    self.extended_value_4 ||= -1
    self.extended_value_5 ||= -1
  end

  def output
    $output = "#{self.trigger_type} #{self.exit.room.formal_vnum} #{self.exit.direction} #{self.name}"
    
    if self.trigger_type == 'Q'
      if self.name == 'trig_block_heathen'
        $output = $output << " #{self.extended_value_1} #{get_string_vnum(self.extended_value_2)} #{get_string_vnum(self.extended_value_3)} #{self.extended_value_4} #{self.extended_value_5}"
      end
      if self.name == 'trig_sentinel_mob'
        $output = $output << " #{obj_info(self.extended_value_1, 'formal_vnum')} #{get_string_vnum(self.extended_value_2)} #{get_string_vnum(self.extended_value_3)} #{self.extended_value_4 == -1 ? -1 : mobile_info(self.extended_value_4, 'formal_vnum')} #{self.extended_value_5}"
      end
      if self.name == 'trig_time_block'
        $output = $output << " #{self.extended_value_1} #{self.extended_value_2} #{get_string_vnum(self.extended_value_3)} #{get_string_vnum(self.extended_value_4)} -1"
      end
    end
    
    $output = $output << " * #{self.comment}"
    return $output
  end
  
  def comment
    $comment = "#{self.exit.room.name} (#{exit.direction_word})"
    
    if self.name == 'trig_block_heathen'
      $comment = $comment << ": allow followers#{self.bit_1 == true ? ', UA PCs' : ''}#{self.bit_2 == true ? ', venerators' : ''}#{self.bit_3 == true ? ', NPCs' : ''}"
    end
    if self.name == 'trig_sentinel_mob'
      $comment = $comment << ": hold #{obj_info(self.extended_value_1, 'sdesc')} #{self.extended_value_4 == -1 ? '' : 'for ' << mobile_info(self.extended_value_4, 'sdesc') << ' ' }for passage"
    end
    if self.name == 'trig_time_block'
      $comment = $comment << ": deny access between #{hour_from_num(self.extended_value_1)} and #{hour_from_num(self.extended_value_2)}"
    end

    return $comment
  end

end