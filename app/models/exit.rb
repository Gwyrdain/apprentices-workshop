class Exit < ActiveRecord::Base
  belongs_to :room
  
  validates :direction, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   less_than_or_equal_to: 5,
                                  }
  validates :description, length: { minimum: 4 }
  validates :keywords, length: { in: 4..75 }
  validates :exittype, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: -1,
                                   less_than_or_equal_to: 4,
                                  }
  validates :keyvnum, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: -1,
                                  }
  validates :exitto, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: -1,
                                  }
  validates :name, length: { in: 4..75 }


end
