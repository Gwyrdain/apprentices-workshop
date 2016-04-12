class AreaString < ActiveRecord::Base
  belongs_to :area

  validates :vnum, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   :less_than => :max_vnum,
                                   message: "Can't exceed max allowable vnum."
                                  },
                   uniqueness:   { scope: :area,
                                   message: "No duplicate vnums allowed." }
  validates :message_to_pc, length: { in: 4..75 }
  validates :message_to_room, length: { in: 4..75 }
  
  validate do |areastring|
    areastring.errors.add :base, "Message to PC may only contain US-ASCII characters.  Invalid characters: " + areastring.message_to_pc.remove(/[\x0A\x0D -~]/) if areastring.message_to_pc.remove(/[\x0A\x0D -~]/).length > 0
    areastring.errors.add :base, "Message to Room may only contain US-ASCII characters.  Invalid characters: " + areastring.message_to_room.remove(/[\x0A\x0D -~]/) if areastring.message_to_room.remove(/[\x0A\x0D -~]/).length > 0
  end

  def max_vnum
    area.vnum_qty
  end
  
  def formal_vnum
    (area.area_number * 100) + self.vnum
  end

  def vnum_and_strings
    return  format("%03d",self.vnum) + " | " + self.message_to_pc + " | " + self.message_to_room
  end

end