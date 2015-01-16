class Area < ActiveRecord::Base
    belongs_to :user
    has_many :helps
    has_many :rooms

    validates :name, length: { in: 1..20 }
    validates :author, length: { in: 1..8 }
    validates :difficulty, length: { is: 5 }
    validates :flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
