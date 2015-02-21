//  --=={ Form Setup / Visuals }==-

function initAreasForm() {
  setFlags();
}

function setFlags() {
  if( $('#area_natural').is(':checked')) {
    $('#NonNaturalFlags').prop('disabled', true)
    $('#NaturalFlag').prop('disabled', false)
  } else {
    $('#NonNaturalFlags').prop('disabled', false)
    $('#NaturalFlag').prop('disabled', true)
  }
}

//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#area_natural').change(function() {
    setFlags()
  })
});

//  --=={ GENERAL FUNCTIONS }==-

