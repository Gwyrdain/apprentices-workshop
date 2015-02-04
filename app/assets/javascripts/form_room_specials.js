//  --=={ Form Setup / Visuals }==-

function initRoomSpecialsForm() {
  setRoomSpecFunType();
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

//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#room_special_room_special_type').change(function() {
    setRoomSpecFunType()
  })
});
