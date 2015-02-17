//  --=={ Form Setup / Visuals }==-

function initTriggersForm() {
  setTriggerType();
  setExtendedTriggerType();
}

function setTriggerType() {
  if( $('#trigger_trigger_type').val() == 'A' ) {
    
    $('#TriggerAfterMove').prop('disabled', false).show();
    $('#TriggerBeforeMove').prop('disabled', true).hide();
    $('#ExtendedTriggerBeforeMove').prop('disabled', true).hide();

  }
  if( $('#trigger_trigger_type').val() == 'P' ) {
    
    $('#TriggerAfterMove').prop('disabled', true).hide();
    $('#TriggerBeforeMove').prop('disabled', false).show();
    $('#ExtendedTriggerBeforeMove').prop('disabled', true).hide();

  }
  if( $('#trigger_trigger_type').val() == 'Q' ) {
    
    $('#TriggerAfterMove').prop('disabled', true).hide();
    $('#TriggerBeforeMove').prop('disabled', true).hide();
    $('#ExtendedTriggerBeforeMove').prop('disabled', false).show();
    setExtendedTriggerType();
  }
}

function setExtendedTriggerType() {
  $('#xBlockHeathen').prop('disabled', true).hide();
  $('#xSentinelMob').prop('disabled', true).hide();
  $('#xTimeBlock').prop('disabled', true).hide();
  $('#xGeneric').prop('disabled', true).hide();
  
  if( $('#trigger_trigger_type').val() == 'Q' ) {
    
    if( $('#ExtendedTriggerBeforeMoveType').val() == 'trig_block_heathen' ) {
      $('#xGeneric').prop('disabled', false).show();
    }
    if( $('#ExtendedTriggerBeforeMoveType').val() == 'trig_sentinel_mob' ) {
      $('#xGeneric').prop('disabled', false).show();
    }
      if( $('#ExtendedTriggerBeforeMoveType').val() == 'trig_time_block' ) {
      $('#xTimeBlock').prop('disabled', false).show();
    }
    
  }
  
}

//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#trigger_trigger_type').change(function() {
    setTriggerType()
    setExtendedTriggerType()
  })
});

$(function() {
  $('#ExtendedTriggerBeforeMoveType').change(function() {
    setExtendedTriggerType()
  })
});

$(function() {
  $('#StartTime').change(function() {
    checkTimes()
  })
});

$(function() {
  $('#EndTime').change(function() {
    checkTimes()
  })
});

//  --=={ FORM VALIDATIONS }==-
function checkTimes() {

  if( $('#StartTime').val() >= $('#EndTime').val() ) {
        bootbox.alert('End time must be greater than start time.  Increasing end time.');
        $('#EndTime').val( parseInt($('#StartTime').val(), 10) + 1 );
    return false
  }
  return true
}