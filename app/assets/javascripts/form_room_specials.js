//  --=={ Form Setup / Visuals }==-

function initRoomSpecialsForm() {
  setRoomSpecFunType();
  setExtendedRoomSpecFunLabels();
}

function setRoomSpecFunType() {
  if( $('#room_special_room_special_type').val() == 'E' ) {
    
    $('#NormalSpecialFunction').prop('disabled', true).hide();
    $('#ExtendedSpecialFuntion').prop('disabled', false).show();

  } else {

    $('#NormalSpecialFunction').prop('disabled', false).show();
    $('#ExtendedSpecialFuntion').prop('disabled', true).hide();

  }
}

function setExtendedRoomSpecFunLabels() {
  $('#xCheckDoorOpen').prop('disabled', true).hide()
    
  if( $('#room_special_room_special_type').val() == 'E' &&
      $('#ExtendedRoomSpecialField').val() == 'spec_check_door_open' ) {
    $('#xCheckDoorOpen').prop('disabled', false).show()
  }

}


//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#room_special_room_special_type').change(function() {
    setRoomSpecFunType()
    setExtendedRoomSpecFunLabels();
  })
});

$(function() {
  $('#ExtendedRoomSpecialField').change(function() {
    setExtendedRoomSpecFunLabels()
  })
});