#The Apprentice's Workshop Notepad
---

## General
* Add jQ/AJAX for better experience!

## Areas
* ~~Add default area terrain and room_flags.~~ Done
* ~~What about deleting an Area record... need to clean up assocaited records!~~ Added dependent: :destroy to all has_many associations.  Need to carry this through.

## Helps
* None.

## Rooms
* ~~Pull in default area terrain and room_flags where appropriate.~~ Done
* ~~Need checker for exits:~~
  - ~~opposite_dir added.~~ Done
  - ~~Re-write testing of bad exits to distiguish external vnums, look-only exit directions, and actual BAD exits.~~  Added .is_bad?  No way to test for valid external vnums?
  - ~~one-way (N to room with no S),~~ Done
  - ~~reciprocal (N to room, S back to 1st),~~ Done
  - ~~illogical (N to room, S to somewhere else).~~ Done
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



  <div class="form-group">
    <%= f.label 'external_vnum_cb', 'Assign External Vnum', :class => 'control-label col-md-2' %>
    <div class="col-md-10">
      <%= f.check_box :exit_room_id, {:id => 'external_vnum_cb', :class => "checkbox"}, 1 %>
    </div>
  </div>

  <div class="form-group">
    <%= f.label :exit_room_id, 'External Vnum', :class => 'control-label col-md-2' %>
    <div class="col-md-10">
      <%= f.text_field :exit_room_id, {:id => 'external_vnum', disabled: 'disabled', class: "form-control"} %>
    </div>
  </div>
  
        $('#external_vnum_cb').click(function() {
          var external_vnum_cb_state = $('#external_vnum_cb').is(':checked');
          var exit_undefined_cb_state = $('#undefined_room').is(':checked');
          var selected_exittype = $('#exit_exittype').val();
          if(selected_exittype == -1) {
            alert('Destination room must be undefined when ExitType = 0 (i.e., not an exit)')
            $('#undefined_room').prop('checked', true);
            $('#external_vnum_cb').prop('checked', false);
            $('#exit_exit_room_id').prop('disabled', true);
            $('#external_vnum').prop('disabled', true);
          } else {
            $('#external_vnum').prop('disabled', !external_vnum_cb_state);
            $('#undefined_room').prop('disabled', external_vnum_cb_state);
            $('#undefined_room').prop('checked', !external_vnum_cb_state);
          }
      });