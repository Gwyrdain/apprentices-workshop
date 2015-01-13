class Area < ActiveRecord::Base
    belongs_to :user
    
    validates :name, length: { in: 1..20 }
    validates :author, length: { in: 1..8 }
    validates :difficulty, length: { is: 5 }

end
