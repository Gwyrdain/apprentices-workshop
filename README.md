The Apprentice's Workshop
=========================

Things to do notes
-----------
* Add default area terrain and room_flags.  Ready to go in rooms controller.
* Need checker for exits: one-way (N to room with no S), reciprocal (N to room, S back to 1st), illogical (N to room, S to somewhere else). 
* Change room.exit.exitto to use the room_id of the connecting room rather than vnum! This is critical for a simple renumbering scheme. Requires create room on exit creation? or allow null but use warnings/no export? What about external connections?  Maybe allowable external vnums can be defined and the area level, then used in exitto validation.








      <%= link_to 'New Default Room', {:controller => "rooms", 
                                       :action => "create", 
                                       :vnum => @area.nextroomvnum,
                                       :name => 'Room Name',
                                       :description => 'Description',
                                       :terrain => 0,
                                       :room_flags => 0,
                                       :area_id => @area.id },
                                       :method => "post" %>
                                       
      <%= link_to new_area_room_path(@area, :vnum => $this_exit.exitto,
                                            :name => 'Room Name',
                                            :description => 'Description',
                                            :terrain => 0,
                                            :room_flags => 0
                                            ), :class => 'btn btn-danger btn-md btn-block' do %>