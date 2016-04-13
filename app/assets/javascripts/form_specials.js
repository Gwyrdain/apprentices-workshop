//  --=={ Form Setup / Visuals }==-

function initSpecialsForm() {
  setSpecFunType();
  setExtendedSpecFunLabels();
  setActOnGiveActionFields();
  updateChanceString();
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
    $('#xCallForHelp').prop('disabled', false).show()
  }
  
  
  if( $('#special_special_type').val() == 'N' &&
      $('#ExtendedSpecialField').val() == 'spec_mage_protector' ) {
    $('#xMageProtector').prop('disabled', false).show()
  }
  
  if( $('#special_special_type').val() == 'N' &&
      $('#ExtendedSpecialField').val() == 'spec_timed_teleport' ) {
    $('#xTimedTeleport').prop('disabled', false).show()
  }

}


function setActOnGiveActionFields() {
  $('#LocalObjFormGroup').prop('disabled', true).hide()
  $('#ExternalObjFormGroup').prop('disabled', true).hide()
  $('#ActOnGive_GiveObj').prop('disabled', true).hide()
  $('#ActOnGive_Transfer').prop('disabled', true).hide()

  if( $('#MobilesAction').val() == '0' &&
      $('#ExtendedSpecialField').val() == 'spec_act_on_give' ) {
    $('#ActOnGive_Transfer').prop('disabled', false).show()
  }
  
  if( $('#MobilesAction').val() == '1' &&
      $('#ExtendedSpecialField').val() == 'spec_act_on_give' ) {
    $('#ActOnGive_GiveObj').prop('disabled', false).show()
  }


  if($('#LocalVnumRadio').is(':checked')) {
    $('#LocalVnumField').prop('disabled', false).show();
    $('#ExternalVnumField').prop('disabled', true).hide();
    $('#LocalObjFormGroup').prop('disabled', false).show()
  }

  if($('#ExternalVnumRadio').is(':checked')) {
    $('#LocalVnumField').prop('disabled', true).hide();
    $('#ExternalVnumField').prop('disabled', false).show();
    $('#ExternalObjFormGroup').prop('disabled', false).show()
  }
}

function updateChanceString() {
  var chance_val = Math.pow(2,$('#ChanceN').val())
  var chance_pct = ( 1 / chance_val ) * 100
  $('#Chance').val( chance_pct.toFixed(2) + '% (1 in ' + chance_val.toString() + ')' );
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

$(function() {
  $('#MobilesAction').change(function() {
    setActOnGiveActionFields()
  })
});

$(function() {
  $('#ChanceN').change(function() {
    updateChanceString()
  })
});

$(function() {
  $('input[name=ObjLocalityRadioOptions]:radio').change(function() {
    setActOnGiveActionFields();
  })
});

