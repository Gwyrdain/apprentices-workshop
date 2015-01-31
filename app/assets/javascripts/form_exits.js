//  --=={ VALIDATTIONS }==-

//  --=={ VALIDATTIONS }==-

//  --=={ Form Setup / Visuals }==-

function initExitsForm() {
  setKeyFields();
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

function setKeyFields() {
  if( $('#exit_exittype').val() == 1 || $('#exit_exittype').val() ==  2 ) {
    $('#DoorKeyGroup').show();  
  } else {
    $('#DoorKeyGroup').hide();  
  }
}

function setExitDestinationType() {
  hideExitDestinationTypes();
  
  if($('#NoExitVnumRadio').is(':checked')) {
    $('#NoExitField').prop('disabled', false);
    $('#exit_exittype').val('-1');
    $('#ExitDestinationGroup').hide();
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


function hideExitDestinationTypes() {
  $('#exit_exit_room_id').prop('disabled', true).hide();
  $('#LocalVnumFormGroup').prop('disabled', true).hide();
  $('#ExternalVnumField').prop('disabled', true).hide();
  $('#ExternalVnumFormGroup').prop('disabled', true).hide();
  $('#NoExitField').prop('disabled', true);
}


//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#exit_exittype').change(function() {
    setKeyFields();
    setExitType();
  })
});

$(function() {
  $('input[name=ExitDestinationRadioOptions]:radio').change(function() {
    setExitDestinationType();
  })
});


