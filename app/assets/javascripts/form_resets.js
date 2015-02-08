//  --=={ Form Setup / Visuals }==-

function initResetForm() {
  setResetType();
}

function setResetType() {
  hideResetTypes();
  
  if( $('#reset_reset_type').val() == 'M' || $('#reset_reset_type').val() == 'Q') {
    $('#MobileGroup').prop('disabled', false).show(); 
  }
  
  if( $('#reset_reset_type').val() == 'O') {
    $('#ObjectGroup').prop('disabled', false).show(); 
  }
  
  if( $('#reset_reset_type').val() == 'D') {
    $('#DoorGroup').prop('disabled', false).show(); 
  }
  
  if( $('#reset_reset_type').val() == 'R') {
    $('#RandomizeGroup').prop('disabled', false).show(); 
  }

}

//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#reset_reset_type').change(function() {
    setResetType()
  })
});

//  --=={ GENERAL FUNCTIONS }==-

function hideResetTypes() {
 $('#MobileGroup').prop('disabled', true).hide(); 
 $('#ObjectGroup').prop('disabled', true).hide(); 
 $('#DoorGroup').prop('disabled', true).hide(); 
 $('#RandomizeGroup').prop('disabled', true).hide(); 
}