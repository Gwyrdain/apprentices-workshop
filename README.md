#The Apprentice's Workshop Notepad
---

## Areas
* ~~Add default area terrain and room_flags.~~ Done
* ~~What about deleting an Area record... need to clean up assocaited records!~~ Added dependent: :destroy to all has_many associattions.  Need to carry this through.

## Helps
* None.

## Rooms
* ~~Pull in default area terrain and room_flags where appropriate.~~ Done
* Need checker for exits:
  - ~~opposite_dir added.~~
  - one-way (N to room with no S),
  - reciprocal (N to room, S back to 1st),
  - illogical (N to room, S to somewhere else). 
* ~~Change room.exit.exit_room_id to use the room_id of the connecting room rather than vnum!~~ Done
  - ~~Allow vnums to be changed without breaking exits.~~ Yes
  - Requires create room on exit creation? or allow null but use warnings/no export?
  - What about external connections?
  - Maybe allowable external vnums can be defined and the area level, then used in exit_room_id validation.
* Examples of working link_to button , passing default room info
      <%= link_to new_area_room_path(@area, :vnum => $this_exit.exit_room_id,
                                            :name => 'Room Name',
                                            :description => 'Description',
                                            :terrain => 0,
                                            :room_flags => 0
                                            ), :class => 'btn btn-danger btn-md btn-block' do %>
* Examples of working link_to, creating a room with no external input.  Extend to exit creation.
      <%= link_to new_area_room_path(@area, :vnum => $this_exit.exit_room_id,
                                            :name => 'Room Name',
                                            :description => 'Description',
                                            :terrain => 0,
                                            :room_flags => 0
                                            ), :class => 'btn btn-danger btn-md btn-block' do %>

## Objects
* Not started.

## Mobiles
* Not started.
