class Help < ActiveRecord::Base
  belongs_to :area

    validates :min_level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :keywords, length: { in: 4..75 }
    validates :body, length: { minimum: 4 }

end
