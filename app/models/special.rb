class Special < ActiveRecord::Base
  belongs_to :mobile
  
  validates :mobile_id, uniqueness:  { scope: :mobile,
                                       message: "Only one special function allowed per mobile." }
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

end
