//  --=={ Form Setup / Visuals }==-

function initSubResetForm() {
  setSubResetType();
}

function setSubResetType() {
  hideSubResetTypes();

  if( $('#sub_reset_reset_type').val() == 'E') {
    $('#EquipGroup').prop('disabled', false).show();
    $('#NonRandom').prop('disabled', false).show();
  }

  if( $('#sub_reset_reset_type').val() == 'G') {
    $('#GiveGroup').prop('disabled', false).show();
    $('#NonRandom').prop('disabled', false).show();
  }

  if( $('#sub_reset_reset_type').val() == 'C' || $('#sub_reset_reset_type').val() == 'F' ) {
    $('#Random').prop('disabled', false).show();
  }

  if( $('#sub_reset_reset_type').val() == 'P') {
    $('#PutGroup').prop('disabled', false).show();
    $('#NonRandom').prop('disabled', false).show();
  }

}

//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#sub_reset_reset_type').change(function() {
    setSubResetType()
  })
});

//  --=={ GENERAL FUNCTIONS }==-

function hideSubResetTypes() {
 $('#EquipGroup').prop('disabled', true).hide();
 $('#GiveGroup').prop('disabled', true).hide();
 $('#PutGroup').prop('disabled', true).hide();
 $('#Random').prop('disabled', true).hide();
 $('#NonRandom').prop('disabled', true).hide();
}