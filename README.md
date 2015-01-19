#The Apprentice's Workshop Notepad
---

## Areas
* Add default area terrain and room_flags.
* What about deleting an Area record... need to clean up assocaited records!

## Helps
* None.

## Rooms
* Pull in default area terrain and room_flags where appropriate. (Commented out in controller)
* Need checker for exits:
  - one-way (N to room with no S),
  - reciprocal (N to room, S back to 1st),
  - illogical (N to room, S to somewhere else). 
* Change room.exit.exitto to use the room_id of the connecting room rather than vnum!
  - This is critical for a simple renumbering scheme.
  - Requires create room on exit creation? or allow null but use warnings/no export?
  - What about external connections?
  - Maybe allowable external vnums can be defined and the area level, then used in exitto validation.
* Examples of working link_to button , passing default room info
      <%= link_to new_area_room_path(@area, :vnum => $this_exit.exitto,
                                            :name => 'Room Name',
                                            :description => 'Description',
                                            :terrain => 0,
                                            :room_flags => 0
                                            ), :class => 'btn btn-danger btn-md btn-block' do %>
* Examples of working link_to, creating a room with no external input.  Extend to exit creation.
      <%= link_to new_area_room_path(@area, :vnum => $this_exit.exitto,
                                            :name => 'Room Name',
                                            :description => 'Description',
                                            :terrain => 0,
                                            :room_flags => 0
                                            ), :class => 'btn btn-danger btn-md btn-block' do %>

## Objects
* Not started.

## Mobiles
* Not started.
