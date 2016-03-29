class Rxdesc < ActiveRecord::Base
  belongs_to :room
  
  validates :keywords, length: { in: 2..75 }, format: { with: /\A[ -~]+\z/, message: "Only US-ASCII characters are permitted." }
  validates :description, length: { minimum: 4 }, format: { with: /\A[\x0A\x0D -~]+\z/, message: "Only US-ASCII characters are permitted." }

end
