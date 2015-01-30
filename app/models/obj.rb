class Obj < ActiveRecord::Base
  belongs_to :area
  has_many :oxdescs, dependent: :destroy
  has_many :applies, dependent: :destroy

  include Bitfields

  bitfield :wear_flags, 
                    2**0 =>  :takeable,      # Dec:          1 / Hex:         1
                    2**1 =>  :finger,        # Dec:          2 / Hex:         2
                    2**2 =>  :neck,          # Dec:          4 / Hex:         4
                    2**3 =>  :body,          # Dec:          8 / Hex:         8
                    2**4 =>  :head,          # Dec:         16 / Hex:        10
                    2**5 =>  :legs,          # Dec:         32 / Hex:        20
                    2**6 =>  :feet,          # Dec:         64 / Hex:        40
                    2**7 =>  :hands,         # Dec:        128 / Hex:        80
                    2**8 =>  :arms,          # Dec:        256 / Hex:       100
                    2**9 =>  :shield,        # Dec:        512 / Hex:       200
                    2**10 => :about,         # Dec:       1024 / Hex:       400
                    2**11 => :waist,         # Dec:       2048 / Hex:       800
                    2**12 => :wrist,         # Dec:       4096 / Hex:      1000
                    2**13 => :wield,         # Dec:       8192 / Hex:      2000
                    2**14 => :hold,          # Dec:      16384 / Hex:      4000
                    2**15 => :decoration     # Dec:      32768 / Hex:      8000

  bitfield :extra_flags, 
                    2**0 =>  :glow,          # Dec:          1 / Hex:         1
                    2**1 =>  :hum,           # Dec:          2 / Hex:         2
#                   2**2 =>  :flag,          # Dec:          4 / Hex:         4
#                   2**3 =>  :flag,          # Dec:          8 / Hex:         8
                    2**4 =>  :evil,          # Dec:         16 / Hex:        10
                    2**5 =>  :invis,         # Dec:         32 / Hex:        20
                    2**6 =>  :magic,         # Dec:         64 / Hex:        40
                    2**7 =>  :nodrop,        # Dec:        128 / Hex:        80
#                   2**8 =>  :flag,          # Dec:        256 / Hex:       100
                    2**9 =>  :anti_good,     # Dec:        512 / Hex:       200
                    2**10 => :anti_evil,     # Dec:       1024 / Hex:       400
                    2**11 => :anti_neutral,  # Dec:       2048 / Hex:       800
                    2**12 => :noremove,      # Dec:       4096 / Hex:      1000
                    2**13 => :inventory,     # Dec:       8192 / Hex:      2000
                    2**14 => :metallic,      # Dec:      16384 / Hex:      4000
                    2**15 => :good,          # Dec:      32768 / Hex:      8000
#                   2**16 => :flag,          # Dec:      65536 / Hex:     10000
                    2**17 => :not_purgable,  # Dec:     131072 / Hex:     20000
                    2**18 => :flammable,     # Dec:     262144 / Hex:     40000
                    2**19 => :two_handed,    # Dec:     524288 / Hex:     80000
#                   2**20 => :flag,          # Dec:    1048576 / Hex:    100000
                    2**21 => :use_cost,      # Dec:    2097152 / Hex:    200000
#                   2**22 => :flag,          # Dec:    4194304 / Hex:    400000
#                   2**23 => :flag,          # Dec:    8388608 / Hex:    800000
#                   2**24 => :flag,          # Dec:   16777216 / Hex:   1000000
                    2**25 => :anti_unalign,  # Dec:   33554432 / Hex:   2000000
#                   2**26 => :flag,          # Dec:   67108864 / Hex:   4000000
#                   2**27 => :flag,          # Dec:  134217728 / Hex:   8000000
                    2**28 => :neutral,        # Dec:  268435456 / Hex:  10000000
                    2**29 => :no_hoard,      # Dec:  536870912 / Hex:  20000000
                    2**30 => :masked        # Dec: 1073741824 / Hex:  40000000
#                   2**31 => :flag,          # Dec: 2147483648 / Hex:  80000000
#                   2**32 => :flag           # Dec: 4294967296 / Hex: 100000000

  bitfield :misc_flags, 
#                    2**0 =>  :flag,             # Dec:          1 / Hex:         1
#                    2**1 =>  :flag,             # Dec:          2 / Hex:         2
#                    2**2 =>  :flag,             # Dec:          4 / Hex:         4
                    2**3 =>  :underwater_breath # Dec:          8 / Hex:         8

  validates :vnum, :numericality => { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   :less_than => :max_vnum,
                                   message: "Can't exceed max allowable vnum."
                                  },
                   uniqueness:   { scope: :area,
                                   message: "No duplicate vnums allowed." }
  validates :keywords, length: { in: 4..75 }
  validates :sdesc, length: { in: 4..75 }
  validates :ldesc, length: { minimum: 4 }
  validates :object_type, numericality: { only_integer: true, greater_than: 0 }
  validates :v0, numericality: { only_integer: true, greater_than: -2 }
  validates :v1, numericality: { only_integer: true, greater_than: -2 }
  validates :v2, numericality: { only_integer: true, greater_than: -2 }
  validates :v3, numericality: { only_integer: true, greater_than: -2 }
  validates :wear_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :extra_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :misc_flags, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :default_values
  def default_values
    self.v0 ||= 0
    self.v1 ||= 0
    self.v2 ||= 0
    self.v3 ||= 0
    self.extra_flags ||= 0
    self.wear_flags ||= 1
    self.misc_flags ||= 0
    self.weight ||= 0
    self.cost ||= 0
  end

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


def spell_from_num(i)
  $spell = nil
  $spell = 'Acid Blast' if i == 70
  $spell = 'Alarm' if i == 48
  $spell = 'Animate Dead' if i == 97
  $spell = 'Armor' if i == 1
  $spell = 'Attunement' if i == 125
  $spell = 'Bear Totem' if i == 127
  $spell = 'Bless' if i == 3
  $spell = 'Blindness' if i == 4
  $spell = 'Boar Totem' if i == 126
  $spell = 'Burning Hands' if i == 5
  $spell = 'Call Lightning' if i == 6
  $spell = 'Cause Critical Wounds' if i == 63
  $spell = 'Cause Disease' if i == 105
  $spell = 'Cause Light Wounds' if i == 62
  $spell = 'Cause Serious Wounds' if i == 64
  $spell = 'Change Sex' if i == 82
  $spell = 'Charm Person' if i == 7
  $spell = 'Chill Touch' if i == 8
  $spell = 'Cloak of Protection' if i == 118
  $spell = 'Colour Spray' if i == 10
  $spell = 'Comprehend' if i == 46
  $spell = 'Confusion' if i == 113
  $spell = 'Continual Light' if i == 57
  $spell = 'Control Weather' if i == 11
  $spell = 'Create Food' if i == 12
  $spell = 'Create Spring' if i == 80
  $spell = 'Create Water' if i == 13
  $spell = 'Cure Blindness' if i == 14
  $spell = 'Cure Critical Wounds' if i == 15
  $spell = 'Cure Deafness' if i == 99
  $spell = 'Cure Disease' if i == 104
  $spell = 'Cure Light Wounds' if i == 16
  $spell = 'Cure Mute' if i == 139
  $spell = 'Cure Poison' if i == 43
  $spell = 'Cure Serious Wounds' if i == 61
  $spell = 'Curse' if i == 17
  $spell = 'Darkness' if i == 86
  $spell = 'Deafness' if i == 52
  $spell = 'Detect Disease' if i == 117
  $spell = 'Detect Evil' if i == 18
  $spell = 'Detect Good' if i == 9
  $spell = 'Detect Hidden' if i == 44
  $spell = 'Detect Invisibility' if i == 19
  $spell = 'Detect magic' if i == 20
  $spell = 'Detect Poison' if i == 21
  $spell = 'Dispel Evil' if i == 22
  $spell = 'Dispel Good' if i == 37
  $spell = 'Dispel Magic' if i == 59
  $spell = 'Earthquake' if i == 23
  $spell = 'Enchant Weapon' if i == 24
  $spell = 'Energy Drain' if i == 25
  $spell = 'Exclude' if i == 163
  $spell = 'Faerie Fire' if i == 72
  $spell = 'Faerie Fog' if i == 73
  $spell = 'Fear' if i == 106
  $spell = 'Fireball' if i == 26
  $spell = 'Flamestrike' if i == 65
  $spell = 'Fly' if i == 56
  $spell = 'Gate a Vampire' if i == 83
  $spell = 'Give Health' if i == 120
  $spell = 'Give Mana' if i == 121
  $spell = 'Give Moves' if i == 122
  $spell = 'Hailstorm' if i == 134
  $spell = 'Harm' if i == 27
  $spell = 'Heal' if i == 28
  $spell = 'Hurricane' if i == 135
  $spell = 'Identify' if i == 53
  $spell = 'Immunity' if i == 116
  $spell = 'Improved Identify' if i == 55
  $spell = 'Improved Invisibility' if i == 142
  $spell = 'Infravision' if i == 77
  $spell = 'Invisibility' if i == 29
  $spell = 'Jump' if i == 47
  $spell = 'Know Alignment' if i == 58
  $spell = 'Lightning Bolt' if i == 30
  $spell = 'Locate Object' if i == 31
  $spell = 'Magic Missile' if i == 32
  $spell = 'Magic Stone' if i == 131
  $spell = 'Mass Invisibility' if i == 69
  $spell = 'Meteor Swarm' if i == 95
  $spell = 'Mute' if i == 138
  $spell = 'Naturalize' if i == 95
  $spell = 'Onset of Disease' if i == 115
  $spell = 'Owl Totem' if i == 129
  $spell = 'Pass Door' if i == 74
  $spell = 'Pass Without Trace' if i == 100
  $spell = 'Phosphate' if i == 124
  $spell = 'Poison' if i == 33
  $spell = 'Portal' if i == 88
  $spell = 'Protection from Evil' if i == 34
  $spell = 'Protection from Good' if i == 45
  $spell = 'Quiet' if i == 108
  $spell = 'Refresh' if i == 81
  $spell = 'Remove Curse' if i == 35
  $spell = 'Remove Fear' if i == 107
  $spell = 'Rift Souls' if i == 119
  $spell = 'Sanctuary' if i == 36
  $spell = 'Shield' if i == 67
  $spell = 'Shocking Grasp' if i == 51
  $spell = 'Silence' if i == 112
  $spell = 'Sleep' if i == 38
  $spell = 'Soul Sense' if i == 123
  $spell = 'Spiritual Hammer' if i == 132
  $spell = 'Stone Skin' if i == 66
  $spell = 'Strength' if i == 39
  $spell = 'Summon' if i == 40
  $spell = 'Sunlight' if i == 140
  $spell = 'Survey' if i == 137
  $spell = 'Teleport' if i == 2
  $spell = 'Thunderclap' if i == 136
  $spell = 'Tongues' if i == 98
  $spell = 'True Seeing' if i == 103
  $spell = 'Unicorn Totem' if i == 130
  $spell = 'Vampiric Touch' if i == 85
  $spell = 'Ventriloquate' if i == 41
  $spell = 'Water Breathing' if i == 133
  $spell = 'Weaken' if i == 68
  $spell = 'Weasel Totem' if i == 128
  $spell = 'Wizard Mark' if i == 49
  $spell = 'Word of Recall' if i == 42
  return $spell
end

def liquid_type_from_num(i)
  $liquid_type = nil
  $liquid_type = 'Water (clear)' if i == 0
  $liquid_type = 'Beer (amber)' if i == 1
  $liquid_type = 'Wine (rose)' if i == 2
  $liquid_type = 'Ale (brown)' if i == 3
  $liquid_type = 'Darkale (dark)' if i == 4
  $liquid_type = 'Whiskey (golden)' if i == 5
  $liquid_type = 'Lemonade (pink)' if i == 6
  $liquid_type = 'Firebreather (boiling)' if i == 7
  $liquid_type = 'Local Specialty (everclear)' if i == 8
  $liquid_type = 'Slime (green)' if i == 9
  $liquid_type = 'Milk (white)' if i == 10
  $liquid_type = 'Tea (tan)' if i == 11
  $liquid_type = 'Coffee (black)' if i == 12
  $liquid_type = 'Blood (red)' if i == 13
  $liquid_type = 'Saltwater (clear)' if i == 14
  $liquid_type = 'Mead (thick golden)' if i == 15
  $liquid_type = 'Dew (clear yellow)' if i == 16
  return $liquid_type
end

def poison_yes_no(i)
  $poison = nil
  $poison = 'No' if i == 0
  $poison = 'Yes' if i == 1
  return $poison
end

def damage_type_from_num(i)
  $damage_type = nil
  $damage_type = 'hits (blunt)' if i == 0
  $damage_type = 'slices (sharp)' if i == 1
  $damage_type = 'stabs (sharp, backstabs)' if i == 2
  $damage_type = 'slashs (sharp)' if i == 3
  $damage_type = 'whips (blunt)' if i == 4
  $damage_type = 'claws (sharp)' if i == 5
  $damage_type = 'blasts (blunt)' if i == 6
  $damage_type = 'pounds (blunt)' if i == 7
  $damage_type = 'crushs (blunt)' if i == 8
  $damage_type = 'strikes (blunt)' if i == 9
  $damage_type = 'bites (sharp)' if i == 10
  $damage_type = 'pierces (sharp, backstabs)' if i == 11
  $damage_type = 'smites (blunt)' if i == 12
  return $damage_type
end

def container_flags_from_num(i)
  $container_flags = nil
  $container_flags = 'Not Closeable' if i == 0
  $container_flags = 'Closeable' if i == 1
  $container_flags = 'Closed / Closeable' if i == 5
  $container_flags = 'Locked / Closed / Closeable' if i == 13
  $container_flags = 'Pickproof / Locked / Closed / Closeable' if i == 15
  return $container_flags.upcase
end

def object_type_from_num(i)
  $object_type = nil
  $object_type = 'ARMOR' if i == 9
  $object_type = 'ARMOR ANIMAL' if i == 14
  $object_type = 'BOAT' if i == 22
  $object_type = 'CONTAINER' if i == 15
  $object_type = 'DECORATION' if i == 27
  $object_type = 'DRINK CONTAINER' if i == 17
  $object_type = 'FETISH' if i == 7
  $object_type = 'FOOD' if i == 19
  $object_type = 'FOUNTAIN' if i == 25
  $object_type = 'FURNITURE' if i == 12
  $object_type = 'JEWELRY' if i == 30
  $object_type = 'KEY' if i == 18
  $object_type = 'LIGHT' if i == 1
  $object_type = 'MONEY' if i == 20
  $object_type = 'PET FOOD' if i == 11
  $object_type = 'PILL' if i == 26
  $object_type = 'POTION' if i == 10
  $object_type = 'RELIC' if i == 33
  $object_type = 'RING' if i == 29
  $object_type = 'SCROLL' if i == 2
  $object_type = 'STAFF' if i == 4
  $object_type = 'TRASH' if i == 13
  $object_type = 'TREASURE' if i == 8
  $object_type = 'WAND' if i == 3
  $object_type = 'WEAPON' if i == 5
  $object_type = 'WEAPON ANIMAL' if i == 6
  return $object_type
end
