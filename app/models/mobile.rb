class Mobile < ActiveRecord::Base
  belongs_to :area

  include Bitfields
  
  bitfield :langs_known, 
                    2**0 =>  :common,        # Dec:          1 / Hex:         1
                    2**1 =>  :dwarven,       # Dec:          2 / Hex:         2
                    2**2 =>  :elven,         # Dec:          4 / Hex:         4
                    2**3 =>  :gnomish,       # Dec:          8 / Hex:         8
                    2**4 =>  :halfling,      # Dec:         16 / Hex:        10
                    2**5 =>  :aarakocra,     # Dec:         32 / Hex:        20
                    2**6 =>  :giant,         # Dec:         64 / Hex:        40
                    2**7 =>  :minotaur,      # Dec:        128 / Hex:        80
                    2**8 =>  :ogre,          # Dec:        256 / Hex:       100
                    2**9 =>  :thoras,        # Dec:        512 / Hex:       200
                    2**10 => :goblin,        # Dec:       1024 / Hex:       400
                    2**11 => :drow,          # Dec:       2048 / Hex:       800
                    2**12 => :kobold,        # Dec:       4096 / Hex:      1000
                    2**13 => :orc,           # Dec:       8192 / Hex:      2000
                    2**14 => :troll,         # Dec:      16384 / Hex:      4000
                    2**15 => :sahaguin,      # Dec:      32768 / Hex:      8000
                    2**16 => :god            # Dec:      65536 / Hex:     10000

  def max_vnum
    area.vnum_qty
  end
  
  def formal_vnum
    (area.area_number * 100) + self.vnum
  end

  def vnum_and_sdesc
    return  format("%03d",self.vnum) + " " + self.sdesc
  end

end

def lang_from_num(i)
  $lang = nil
  $lang = 'COMMON'    if i == 1
  $lang = 'DWARVEN'   if i == 2
  $lang = 'ELVEN'     if i == 4
  $lang = 'GNOMISH'   if i == 8
  $lang = 'HALFLING'  if i == 16
  $lang = 'AARAKOCRA' if i == 32
  $lang = 'GIANT'     if i == 64
  $lang = 'MINOTAUR'  if i == 128
  $lang = 'OGRE'      if i == 256
  $lang = 'THORAS'    if i == 512
  $lang = 'GOBLIN'    if i == 1024
  $lang = 'DROW'      if i == 2048
  $lang = 'KOBOLD'    if i == 4096
  $lang = 'ORC'       if i == 8192
  $lang = 'TROLL'     if i == 16384
  $lang = 'SAHAGUIN'  if i == 32768
  $lang = 'GOD'       if i == 65535
  return $lang.upcase
end