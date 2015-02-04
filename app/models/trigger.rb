class Trigger < ActiveRecord::Base
  belongs_to :exit

  validates :exit_id, uniqueness:  { scope: :exit,
                                       message: "Only one trigger allowed per exit." }
  
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

end