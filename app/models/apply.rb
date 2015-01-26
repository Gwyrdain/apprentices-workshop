class Apply < ActiveRecord::Base
  belongs_to :obj
  
  validates :apply_type, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :magnitude, numericality: { only_integer: true }

end
