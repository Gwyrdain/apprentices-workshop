//  --=={ VALIDATTIONS }==-

//  --=={ VALIDATTIONS }==-

//  --=={ Form Setup / Visuals }==-

function initExitsForm() {
  setKeyType();
  setExitType();
  setExitDestinationType();
}

function setExitType() {
  if( $('#exit_exittype').val() == -1 ) { // IF it's a LOOK-ONLY exit.
    hideExitDestinationTypes();
    $('#ExitDestinationGroup').hide();
  } else {
    $('#ExitDestinationGroup').show();
    if($('#NoExitVnumRadio').is(':checked')) { // IF it's not LOOK-ONLY but it's set to 'no exit' reset to a local vnum.
      $('#LocalVnumRadio').prop('checked', true);
      $('#LocalVnumFormGroup').prop('disabled', false).show();
    }
    setExitDestinationType();
  }
}

function setKeyType() {
  if( $('#exit_exittype').val() == 1 || $('#exit_exittype').val() ==  2 ) {
    $('#DoorKeyGroup').show();
    if($('#NoDoorKeyRadio').is(':checked')) { // IF it's LOCKABLE but no key is specified, reset to a local vnum.
      $('#LocalDoorKeyVnumRadio').prop('checked', true);
      $('#LocalDoorKeyVnumGroup').prop('disabled', false).show();
    }
    setKeyFields();
  } else {
    $('#DoorKeyGroup').hide();  
    $('#NoDoorKeyRadio').prop('checked', true);
    $('#NoDoorKeyField').prop('disabled', false);
  }
}

function setExitDestinationType() {
  hideExitDestinationTypes();
  
  if($('#NoExitVnumRadio').is(':checked')) {
    $('#NoExitField').prop('disabled', false);
    $('#exit_exittype').val('-1');
    $('#ExitDestinationGroup').hide();
    setKeyType();
  }
  
  if($('#LocalVnumRadio').is(':checked')) {
    $('#exit_exit_room_id').prop('disabled', false).show();
    $('#LocalVnumFormGroup').prop('disabled', false).show();
  }
  
  if($('#ExternalVnumRadio').is(':checked')) {
    $('#ExternalVnumField').prop('disabled', false).show();
    $('#ExternalVnumFormGroup').prop('disabled', false).show();
  }
  
}

function setKeyFields() {
  hideKeyTypes();
  
  if($('#NoDoorKeyRadio').is(':checked')) {
    $('#NoDoorKeyField').prop('disabled', false);
    $('#exit_exittype').val('0');
    $('#DoorKeyGroup').hide();
  }
  
  if($('#LocalDoorKeyVnumRadio').is(':checked')) {
    $('#LocalDoorKeyVnumField').prop('disabled', false).show();
    $('#LocalDoorKeyVnumGroup').prop('disabled', false).show();
  }
  
  if($('#ExternalDoorKeyVnumRadio').is(':checked')) {
    $('#ExternalDoorKeyVnumField').prop('disabled', false).show();
    $('#ExternalDoorKeyVnumGroup').prop('disabled', false).show();
  }
  
}


function hideExitDestinationTypes() {
  $('#exit_exit_room_id').prop('disabled', true).hide();
  $('#LocalVnumFormGroup').prop('disabled', true).hide();
  $('#ExternalVnumField').prop('disabled', true).hide();
  $('#ExternalVnumFormGroup').prop('disabled', true).hide();
  $('#NoExitField').prop('disabled', true);
}

function hideKeyTypes() {
  $('#LocalDoorKeyVnumField').prop('disabled', true).hide();
  $('#LocalDoorKeyVnumGroup').prop('disabled', true).hide();
  $('#ExternalDoorKeyVnumField').prop('disabled', true).hide();
  $('#ExternalDoorKeyVnumGroup').prop('disabled', true).hide();
  $('#NoDoorKeyField').prop('disabled', true);
}


//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#exit_exittype').change(function() {
    setKeyType();
    setExitType();
  })
});

$(function() {
  $('input[name=ExitDestinationRadioOptions]:radio').change(function() {
    setExitDestinationType();
  })
});

$(function() {
  $('input[name=DoorKeyVnumRadioOptions]:radio').change(function() {
    setKeyFields();
  })
});


