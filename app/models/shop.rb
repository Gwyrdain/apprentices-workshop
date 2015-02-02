class Shop < ActiveRecord::Base
  belongs_to :mobile
  
  validates :mobile_id, uniqueness:  { scope: :mobile,
                                       message: "Only one shop allowed per mobile." }
  
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