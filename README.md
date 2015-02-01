#The Apprentice's Workshop Notepad
---

## General
* Add jQ/AJAX for better experience!
* Add dependent: :destroy to all has_many associations moving forward.

## Areas
* Do keys similar to Container keys.
* Is SEAFLOOR 131072 (2**17)?

## Helps
* None.

## Rooms
* No not allow export when bad exits exit.

## Objects
* None.

## Mobiles
* stay area flag by default



#Wish List
---
* I always thought a map feature would be nice so the front page of it would include an overhead map of the area and you could click on any room to edit it
* when i was playing with the idea myself I was thinking about having little graphic icons for items, mobs, and rooms and then being able to drag/drop them into their proper place for resets so you’d look at a map of an area and then on the right side of the screen there’d be a list of mobs with little icons and you could drag the icon into the room you want it to reset and it’d do all the resets for you or you can click on the mob or the room and it’d open up the edit screen for that item/mob/room




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



#Misc Notes
---

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
      
      bitfield :misc_flags, 
                    2**0 =>  :flag,          # Dec:          1 / Hex:         1
                    2**1 =>  :flag,          # Dec:          2 / Hex:         2
                    2**2 =>  :flag,          # Dec:          4 / Hex:         4
                    2**3 =>  :flag,          # Dec:          8 / Hex:         8
                    2**4 =>  :flag,          # Dec:         16 / Hex:        10
                    2**5 =>  :flag,          # Dec:         32 / Hex:        20
                    2**6 =>  :flag,          # Dec:         64 / Hex:        40
                    2**7 =>  :flag,          # Dec:        128 / Hex:        80
                    2**8 =>  :flag,          # Dec:        256 / Hex:       100
                    2**9 =>  :flag,          # Dec:        512 / Hex:       200
                    2**10 => :flag,          # Dec:       1024 / Hex:       400
                    2**11 => :flag,          # Dec:       2048 / Hex:       800
                    2**12 => :flag,          # Dec:       4096 / Hex:      1000
                    2**13 => :flag,          # Dec:       8192 / Hex:      2000
                    2**14 => :flag,          # Dec:      16384 / Hex:      4000
                    2**15 => :flag,          # Dec:      32768 / Hex:      8000
                    2**16 => :flag,          # Dec:      65536 / Hex:     10000
                    2**17 => :flag,          # Dec:     131072 / Hex:     20000
                    2**18 => :flag,          # Dec:     262144 / Hex:     40000
                    2**19 => :flag,          # Dec:     524288 / Hex:     80000
                    2**20 => :flag,          # Dec:    1048576 / Hex:    100000
                    2**21 => :flag,          # Dec:    2097152 / Hex:    200000
                    2**22 => :flag,          # Dec:    4194304 / Hex:    400000
                    2**23 => :flag,          # Dec:    8388608 / Hex:    800000
                    2**24 => :flag,          # Dec:   16777216 / Hex:   1000000
                    2**25 => :flag,          # Dec:   33554432 / Hex:   2000000
                    2**26 => :flag,          # Dec:   67108864 / Hex:   4000000
                    2**27 => :flag,          # Dec:  134217728 / Hex:   8000000
                    2**28 => :flag,          # Dec:  268435456 / Hex:  10000000
                    2**29 => :flag,          # Dec:  536870912 / Hex:  20000000
                    2**30 => :flag,          # Dec: 1073741824 / Hex:  40000000
                    2**31 => :flag,          # Dec: 2147483648 / Hex:  80000000
                    2**32 => :flag,          # Dec: 4294967296 / Hex: 100000000


