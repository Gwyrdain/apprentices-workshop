class Rxdesc < ActiveRecord::Base
  belongs_to :room
  
  validates :keywords, length: { in: 4..75 }
  validates :description, length: { minimum: 4 }

end
