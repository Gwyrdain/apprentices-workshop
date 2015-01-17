class Area < ActiveRecord::Base
    belongs_to :user
    has_many :helps
    has_many :rooms

    validates :name, length: { in: 1..20 }
    validates :author, length: { in: 1..8 }
    validates :difficulty, length: { is: 5 }
    validates :flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :vnum_qty, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :default_values
  def default_values
    self.vnum_qty ||= 100
    self.flags ||= 0
  end
  
  def nextroomvnum
    $i = 0
    while Room.exists?(:vnum => $i)  do
        $i +=1
    end
    return $i
  end
  
end
