class Help < ActiveRecord::Base
  belongs_to :area

    validates :min_level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :keywords, length: { in: 4..75 }, format: { with: /\A[ -~]+\z/, message: "Only US-ASCII characters are permitted." }
    validates :body, length: { minimum: 4 }, format: { with: /\A[\x0A\x0D -~]+\z/, message: "Only US-ASCII characters are permitted." }

end
