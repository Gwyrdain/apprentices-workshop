//  --=={ Form Setup / Visuals }==-

function initTriggersForm() {
  setTriggerType();
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

  }
}

//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#trigger_trigger_type').change(function() {
    setTriggerType()
  })
});
