class Oxdesc < ActiveRecord::Base
  belongs_to :obj
  
  validates :keywords, length: { in: 4..75 }, format: { with: /\A[ -~]+\z/, message: "Only US-ASCII characters are permitted." }
  validates :description, length: { minimum: 4 }, format: { with: /\A[\x0A\x0D -~]+\z/, message: "Only US-ASCII characters are permitted." }

end
