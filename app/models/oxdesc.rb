class Oxdesc < ActiveRecord::Base
  belongs_to :obj
  
  validates :keywords, length: { in: 4..75 }
  validates :description, length: { minimum: 4 }

end
