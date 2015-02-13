//  --=={ Form Setup / Visuals }==-

function initSpecialsForm() {
  setSpecFunType();
  setExtendedSpecFunLabels();
}

function setSpecFunType() {
  if( $('#special_special_type').val() == 'N' ) {
    
    $('#NormalSpecialFunction').prop('disabled', true).hide();
    $('#ExtendedSpecialFuntion').prop('disabled', false).show();

  } else {

    $('#NormalSpecialFunction').prop('disabled', false).show();
    $('#ExtendedSpecialFuntion').prop('disabled', true).hide();

  }
}

function setExtendedSpecFunLabels() {
  $('#xGeneric').prop('disabled', true).hide()
  $('#xActOnGive').prop('disabled', true).hide()
  $('#xCallForHelp').prop('disabled', true).hide()
  $('#xMageProtector').prop('disabled', true).hide()
  $('#xTimedTeleport').prop('disabled', true).hide()
    
  if( $('#special_special_type').val() == 'N' &&
      $('#ExtendedSpecialField').val() == 'spec_act_on_give' ) {
    $('#xActOnGive').prop('disabled', false).show()
  }
  
  if( $('#special_special_type').val() == 'N' &&
      $('#ExtendedSpecialField').val() == 'spec_call_for_help' ) {
    $('#xGeneric').prop('disabled', false).show()
  }
  
  
  if( $('#special_special_type').val() == 'N' &&
      $('#ExtendedSpecialField').val() == 'spec_mage_protector' ) {
    $('#xGeneric').prop('disabled', false).show()
  }
  
  if( $('#special_special_type').val() == 'N' &&
      $('#ExtendedSpecialField').val() == 'spec_timed_teleport' ) {
    $('#xGeneric').prop('disabled', false).show()
  }

}

//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#special_special_type').change(function() {
    setSpecFunType()
    setExtendedSpecFunLabels();
  })
});

$(function() {
  $('#ExtendedSpecialField').change(function() {
    setExtendedSpecFunLabels()
  })
});