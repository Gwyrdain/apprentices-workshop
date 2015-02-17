class Trigger < ActiveRecord::Base
  belongs_to :exit

  validates :exit_id, uniqueness:  { scope: :exit,
                                       message: "Only one trigger allowed per exit." }
  validates :extended_value_1, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_2, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_3, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_4, numericality: { only_integer: true, greater_than: -2 }
  validates :extended_value_5, numericality: { only_integer: true, greater_than: -2 }
  
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
        $output = $output << " #{self.extended_value_1} #{self.extended_value_2} #{self.extended_value_3} #{self.extended_value_4} #{self.extended_value_5}"
      end
      if self.name == 'trig_sentinel_mob'
        $output = $output << " #{self.extended_value_1} #{self.extended_value_2} #{self.extended_value_3} #{self.extended_value_4} #{self.extended_value_5}"
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
      $comment = $comment << ": something goes here."
    end
    if self.name == 'trig_sentinel_mob'
      $comment = $comment << ": something goes here."
    end
    if self.name == 'trig_time_block'
      $comment = $comment << ": deny access between #{hour_from_num(self.extended_value_1)} and #{hour_from_num(self.extended_value_2)}"
    end

    return $comment
  end

end