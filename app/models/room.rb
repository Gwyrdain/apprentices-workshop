class Room < ActiveRecord::Base
  belongs_to :area
  
  include Bitfields
  bitfield :room_flags, 1 => :dark, 2 => :no_sleep, 4 => :no_mob, 8 => :indoors, 32 => :foggy, 512 => :private, 1024 => :peaceful, 2048 => :solitary, 8192 => :no_recall, 16384 => :no_steal, 32768 => :notrans, 65536 => :no_spell, 262144 => :no_fly, 1048576 => :fly_ok, 2097152 => :no_quest, 4194304 => :no_item, 8388608 => :no_vnum

end


# 1 => :xxx, 2 => :xxx, 4 => :xxx, 8 => :xxx, 16 => :xxx, 32 => :xxx, 64 => :xxx, 128 => :xxx, 256 => :xxx, 512 => :xxx, 1024 => :xxx, 2048 => :xxx, 4096 => :xxx, 8192 => :xxx, 16384 => :xxx, 32768 => :xxx, 65536 => :xxx, 131072 => :xxx, 262144 => :xxx, 524288 => :xxx, 1048576 => :xxx, 2097152 => :xxx, 4194304 => :xxx, 8388608 => :xxx, 16777216 => :xxx, 33554432 => :xxx, 67108864 => :xxx, 134217728 => :xxx, 268435456 => :xxx, 536870912 => :xxx, 1073741824 => :xxx, 2147483648


# 1 => :dark, 2 => :no_sleep, 4 => :no_mob, 8 => :indoors, 32 => :foggy, 64 => :private, 128 => :peaceful, 256 => :solitary, 512 => :no_recall, 1024 => :no_steal, 2048 => :xxx, 4096 => :xxx, 8192 => :xxx, 16384 => :xxx, 32768 => :xxx, 65536 => :xxx, 131072 => :xxx, 262144 => :xxx, 524288 => :xxx, 1048576 => :xxx, 2097152 => :xxx, 4194304 => :xxx, 8388608 => :xxx, 16777216 => :xxx, 33554432 => :xxx, 67108864 => :xxx, 134217728 => :xxx, 268435456 => :xxx, 536870912 => :xxx, 1073741824 => :xxx, 2147483648


#Room Flags
#Flag	Value	Notes
#DARK	1	Room is Dark, can't see w/o light
#NO SLEEP	2	Can't sleep in the room
#NO MOB	4	Mobs don't wander in, but they can leave or pop in room
#INDOORS	8	Cannot Fly unless FLY OK is set. Cannot see sky.
#FOGGY	32	Can't see reliably
#PRIVATE	512	Two occupants only. Cannot portal TO room. Cannot Fly unless FLY OK is set. CAN be summoned from the room.
#PEACEFUL	1024	Saferoom
#SOLITARY	2048	Single occupant only. Cannot portal TO room. Cannot Fly unless FLY OK is set. CAN be summoned from the room.
#NO RECALL	8192	Cannot recall or teleport FROM room
#NO STEAL	16384	Cannot steal in room
#NOTRANS	32768	Cannot portal or bad recall TO room and you cannot summon TO or FROM theroom
#NO SPELL	65536	Cannot cast in room
#NO FLY	262144	Cannot fly in room. Redundant in some cases.
#FLY OK	1048576	Can fly in room. Redundant in some cases.
#NO QUEST	2097152	Rooms not good for MM or LQ type quests.
#NO ITEM	4194304	Can't use magic items in the room.
#NO VNUM	8388608	Don't send vnum through MSDP. Use for maze rooms.