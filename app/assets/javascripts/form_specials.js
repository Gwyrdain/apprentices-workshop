//  --=={ Form Setup / Visuals }==-

function initSpecialsForm() {
  setSpecFunType();
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

//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#special_special_type').change(function() {
    setSpecFunType()
  })
});
