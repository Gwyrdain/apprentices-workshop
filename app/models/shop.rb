class Shop < ActiveRecord::Base
  belongs_to :mobile
  
  validates :mobile_id, uniqueness:  { scope: :mobile,
                                       message: "Only one shop allowed per mobile." }
  validates :buy_type_1, numericality: { only_integer: true, greater_than: -1 }
  validates :buy_type_2, numericality: { only_integer: true, greater_than: -1 }
  validates :buy_type_3, numericality: { only_integer: true, greater_than: -1 }
  validates :buy_type_4, numericality: { only_integer: true, greater_than: -1 }
  validates :buy_type_5, numericality: { only_integer: true, greater_than: -1 }
  validates :open_hour, numericality: { only_integer: true, greater_than: -1 }
  validates :close_hour, numericality: { only_integer: true, greater_than: -1 }
  validates :race, numericality: { only_integer: true, greater_than: -2 }
  
  before_create :default_values
  def default_values
    self.buy_type_1 ||= 0
    self.buy_type_2 ||= 0
    self.buy_type_3 ||= 0
    self.buy_type_4 ||= 0
    self.buy_type_5 ||= 0
    self.open_hour ||= 0
    self.close_hour ||= 0
    self.race ||= -1
  end

end