//  --=={ VALIDATTIONS }==-

function validMaxAC () {
  if( ( $('#obj_object_type').val() == 9 || $('#obj_object_type').val() === 14 ) && // IF ARMOR and if AC > MAX AC
      $('#ItemValueGroupArmor').find('#obj_v0').val() > $('#ItemValueGroupArmor').find('#obj_v1').val() ) {
        bootbox.alert('<strong>Max AC</strong> cannot be less than <strong>AC</strong>.  Setting Max AC to match AC.');
        $('#ItemValueGroupArmor').find('#obj_v1').val( $('#ItemValueGroupArmor').find('#obj_v0').val() );
    return false
  }
  return true
}

function validHoldWeight () {
  if( $('#obj_object_type').val() == 15 &&
      parseInt($('#ItemValueGroupContainer').find('#obj_v0').val()) <= parseInt($('#obj_weight').val()) ) {
        bootbox.alert('Container <strong>hold weight</strong> must be greater than object <strong>weight</strong>.  Increasing hold weight.');
        $('#ItemValueGroupContainer').find('#obj_v0').val( $('#obj_weight').val() + 5 );
        $('#ItemValueGroupContainer').find('#obj_capacity').val( 5 );
    return false
  }
  return true
}

function updateHoldWeight () {
  $('#ItemValueGroupContainer').find('#obj_v0').val( parseInt($('#obj_weight').val()) + parseInt($('#obj_capacity').val()) );
}

function validDrinks () {
  if( $('#obj_object_type').val() == 17 &&
      $('#ItemValueGroupDrink').find('#obj_v0').val() < $('#ItemValueGroupDrink').find('#obj_v1').val() ) {
        bootbox.alert('Drink container <strong># of drinks</strong> must be greater than or equal to the <strong>amount left</strong>.  Increasing # of drinks.');
        $('#ItemValueGroupDrink').find('#obj_v0').val( $('#ItemValueGroupDrink').find('#obj_v1').val() );
    return false
  }
  return true
}

function validCharges () {
  if( $('#ItemValueGroupMultiUseMagicItems').find('#obj_v1').val() < $('#ItemValueGroupMultiUseMagicItems').find('#obj_v2').val() ) {
        bootbox.alert('<strong>Max charges</strong> must be greater than or equal to the <strong>remaining charged</strong>.  Increasing max charges.');
        $('#ItemValueGroupMultiUseMagicItems').find('#obj_v1').val( $('#ItemValueGroupMultiUseMagicItems').find('#obj_v2').val() );
    return false
  }

  if( $('#ItemValueGroupMultiUseMagicItems').find('#obj_v1').val() < 0 ) {
        bootbox.alert('<strong>Max charges</strong> must be a positive integer.');
        $('#ItemValueGroupMultiUseMagicItems').find('#obj_v1').val( '1' );
    return false
  }

  if( $('#ItemValueGroupMultiUseMagicItems').find('#obj_v2').val() < 0 ) {
        bootbox.alert('<strong>Remaining charges</strong> must be a positive integer.');
        $('#ItemValueGroupMultiUseMagicItems').find('#obj_v2').val( '1' );
    return false
  }

  return true
}


function validRange () {
  if( ( $('#obj_object_type').val() == 5 || $('#obj_object_type').val() == 6 ) &&
      parseInt($('#ItemValueGroupWeapon').find('#obj_v2').val(), 10) < parseInt($('#ItemValueGroupWeapon').find('#obj_v1').val(), 10) ) {
        bootbox.alert('Weapon <strong>range max</strong> must be greater than or equal to <strong>range min</strong>.  Increasing range max.');
        $('#ItemValueGroupWeapon').find('#obj_v2').val( $('#ItemValueGroupWeapon').find('#obj_v1').val() );
    return false
  }
  return true
}

function validMetallic () {
  if( $('#obj_metallic').is(':checked') == true &&
    ( $('#obj_object_type').val() != 9 && $('#obj_object_type').val() != 14) ) {
        bootbox.alert('The <strong>METALLIC</strong> flag may only be used with an armor object type.');
        $('#obj_metallic').prop('checked', false);
    return false
  }
  if( $('#obj_metallic').is(':checked') == false &&
    ( $('#obj_object_type').val() == 9 || $('#obj_object_type').val() === 14) &&
      $('#ItemValueGroupArmor').find('#obj_v0').val() > 5 ) {
        bootbox.alert('The <strong>METALLIC</strong> flag set for armor with an AC of greater than 5.');
        $('#obj_metallic').prop('checked', true);
    return false
  }
  return true
}

function validTwoHanded () {
  if( $('#obj_two_handed').is(':checked') == true &&
    ( $('#obj_object_type').val() != 5 && $('#obj_object_type').val() != 6) ) {
        bootbox.alert('<strong>TWO HANDED</strong> flag may only be used with a weapon object type.');
        $('#obj_two_handed').prop('checked', false);
        return false
      } else {
        return true
      }
}

function validUnderwaterBreath () {
  if( $('#obj_underwater_breath').is(':checked') == true &&
    ( $('#obj_object_type').val() != 9 && $('#obj_object_type').val() != 14) ) {
        bootbox.alert('The <strong>UNDERWATER BREATH</strong> flag may only be used with an armor object type.');
        $('#obj_underwater_breath').prop('checked', false);
    return false
  } else {
    return true
  }
}

function validWeight () {
  if( $('#obj_weight').val() > 9 &&
    ($('#obj_object_type').val() == 5 || $('#obj_object_type').val() == 6) &&
      $('#obj_two_handed').is(':checked') == false ) {
        bootbox.alert('<strong>TWO HANDED</strong> flag set for a weapon of weight greater than 9 kg.');
        $('#obj_two_handed').prop('checked', true);
        return false
      } else {
        return true
      }
}

function validUseCost () {
  if($('#obj_cost').val()!= 0 && $('#obj_use_cost').is(':checked') == false) {
    bootbox.alert('Object cost should be 0 since the object is not flagged with <strong>USE COST</strong>.');
    $('#obj_cost').val('0');
    return false
  } else {
    return true
  }
}

//  --=={ WATCH FOR FORM CHANGES }==-

$(function() {
  $('#ItemValueGroupArmor').find('#obj_v0').change(function() { // This is the AC field.
    validMetallic();
    validMaxAC();
  })
});

$(function() {
  $('#ItemValueGroupArmor').find('#obj_v1').change(function() { // This is the MAX AC field.
    validMaxAC();
  })
});

$(function() {
  $('#ItemValueGroupContainer').find('#obj_v0').change(function() { // This is the Hold Weight field.
    validHoldWeight();
  })
});

$(function() {
  $('#ItemValueGroupContainer').find('#obj_v1').change(function() { // This is the Container flags field.
    setKeyValueOptions();
  })
});


$(function() {
  $('#ItemValueGroupDrink').find('#obj_v0').change(function() { // This is the # of drinks field.
    validDrinks();
  })
});

$(function() {
  $('#ItemValueGroupDrink').find('#obj_v1').change(function() { // This is the amount left field.
    validDrinks();
  })
});

$(function() {
  $('input[name=LightRadioOptions]:radio').click(function() {
    setLightValueOptions();
    })
});

$(function() {
  $('input[name=ContainerKeyVnumRadioOptions]:radio').click(function() {
    setKeyValueOptions();
    })
});

$(function() {
  $('#ItemValueGroupMultiUseMagicItems').find('#obj_v1').change(function() { // This is the max charges field.
    validCharges();
  })
});

$(function() {
  $('#ItemValueGroupMultiUseMagicItems').find('#obj_v2').change(function() { // This is the remaining charges field.
    validCharges();
  })
});

$(function() {
  $('#ItemValueGroupWeapon').find('#obj_v1').change(function() { // This is the range min field.
    validRange();
  })
});

$(function() {
  $('#ItemValueGroupWeapon').find('#obj_v2').change(function() { // This is the range max field.
    validRange();
  })
});

$(function() {
  $('#obj_metallic').change(function() {
    validMetallic();
  })
});

$(function() {
  $('#obj_two_handed').change(function() {
    validTwoHanded();
  })
});

$(function() {
  $('#obj_use_cost').change(function() {
    validUseCost();
  })
});

$(function() {
  $('#obj_underwater_breath').change(function() {
    validUnderwaterBreath();
  })
});

$(function() {
  $('#obj_weight').change(function() {
    validWeight();
    validHoldWeight();
    updateHoldWeight();
  })
});

$(function() {
  $('#obj_capacity').change(function() {
    validWeight();
    validHoldWeight();
    updateHoldWeight();
  })
});

$(function() {
  $('#obj_cost').change(function() {
    validUseCost();
  })
});


$(function() {
    $('#obj_object_type').change(function() {

      initObjForm();

      validMaxAC();
      validHoldWeight();
      validDrinks();
      validCharges();
      validRange();
      validMetallic();
      validTwoHanded();
      validUnderwaterBreath();
      validWeight();
      validUseCost();
      addMagicFlag();

    })
});

$(function() {
  $('#obj_evil').change(function() {
    setFormattedObjLdesc();
  })
});

$(function() {
  $('#obj_good').change(function() {
    setFormattedObjLdesc();
  })
});

$(function() {
  $('#obj_invis').change(function() {
    setFormattedObjLdesc();
  })
});

$(function() {
  $('#obj_hum').change(function() {
    setFormattedObjLdesc();
  })
});

$(function() {
  $('#obj_glow').change(function() {
    setFormattedObjLdesc();
  })
});

$(function() {
  $('#obj_magic').change(function() {
    setFormattedObjLdesc();
  })
});

$(function() {
  $('#obj_ldesc').keyup(function() {
    setFormattedObjLdesc();
  })
});

//  --=={ INITIALIZE THE OBJECTS FORM FOR VISIBLE VS HIDDEN }==-

function setObjValues() {

  var i = $( '#obj_object_type' ).val();

  if(i== 1) {
    hideItemGroups();
    $('#ItemValueGroupLight').prop('disabled', false).show();
    $('#obj_takeable').prop('checked', true);
    $('#obj_wear_flags').val('0');
  }
  if(i== 20) {
    hideItemGroups();
    $('#ItemValueGroupMoney').prop('disabled', false).show();
    $('#obj_takeable').prop('checked', true);
    $('#obj_wear_flags').val('0');
  }
  if(i== 17) {
    hideItemGroups();
    $('#ItemValueGroupDrink').prop('disabled', false).show();
    $('#obj_takeable').prop('checked', true);
    $('#obj_wear_flags').val('0');
  }
  if(i== 30) {
    hideItemGroups();
    $('#ItemValueGroupJewelry').prop('disabled', false).show();
    $('#obj_takeable').prop('checked', true);
  }
  if(i== 12 || i== 27) {
    hideItemGroups();
    $('#ItemValueGroupGeneric').prop('disabled', false).show();
    $('#obj_wear_flags').val('0');
    if(i == 27) {$('#obj_wear_flags').val('32768');}; // DECORATION set to WEAR as DECORATION
  }
  if(i== 25) {
    hideItemGroups();
    $('#ItemValueGroupFountain').prop('disabled', false).show();
    $('#obj_takeable').prop('checked', false);
    $('#obj_wear_flags').val('0');
  }
  if(i== 5 || i== 6) {
    hideItemGroups();
    $('#ItemValueGroupWeapon').prop('disabled', false).show();
    $('#obj_two_handed').parent().show();
    $('#obj_takeable').prop('checked', true);
    $('#obj_wear_flags').val('8192');
  }
  if(i== 9 || i== 14) {
    hideItemGroups();
    $('#ItemValueGroupArmor').prop('disabled', false).show();
    $('#obj_metallic').parent().show();
    $('#obj_underwater_breath').parent().show();
    $('#obj_takeable').prop('checked', true);
  }
  if(i== 15) {
    hideItemGroups();
    $('#ItemValueGroupContainer').prop('disabled', false).show();
    $('#obj_wear_flags').val('0');
  }
  if(i== 3 || i== 4 || i== 7 || i== 29 || i== 33) {
    hideItemGroups();
    $('#ItemValueGroupMultiUseMagicItems').prop('disabled', false).show();
    $('#obj_wear_flags').val('16384');
    if(i == 29) {$('#obj_wear_flags').val('2');};  // RING set to WEAR on FINGER
  }
  if(i== 2 || i== 10 || i== 26) {
    hideItemGroups();
    $('#ItemValueGroupSingleUseMagicItems').prop('disabled', false).show();
    $('#obj_takeable').prop('checked', true);
    $('#obj_wear_flags').val('16384');
  }
  if(i== 11 || i== 19) {
    hideItemGroups();
    $('#ItemValueGroupFood').prop('disabled', false).show();
    $('#obj_takeable').prop('checked', true);
    $('#obj_wear_flags').val('0');
  }

}

function addMagicFlag() {
  if( $('#obj_object_type').val() == 2 ||
      $('#obj_object_type').val() == 3 ||
      $('#obj_object_type').val() == 4 ||
      $('#obj_object_type').val() == 7 ||
      $('#obj_object_type').val() == 10 ||
      $('#obj_object_type').val() == 26 ||
      $('#obj_object_type').val() == 29 ||
      $('#obj_object_type').val() == 33 ) {
        bootbox.alert('The <strong>MAGIC</strong> flag has been automatically set for this object type.');
        $('#obj_magic').prop('checked', true);
  }
}

function hideItemGroups() {
  $('#ItemValueGroupGeneric').prop('disabled', true).hide();
  $('#ItemValueGroupMoney').prop('disabled', true).hide();
  $('#ItemValueGroupDrink').prop('disabled', true).hide();
  $('#ItemValueGroupJewelry').prop('disabled', true).hide();
  $('#ItemValueGroupFountain').prop('disabled', true).hide();
  $('#ItemValueGroupWeapon').prop('disabled', true).hide();
  $('#ItemValueGroupLight').prop('disabled', true).hide();
  $('#ItemValueGroupArmor').prop('disabled', true).hide();
  $('#ItemValueGroupContainer').prop('disabled', true).hide();
  $('#ItemValueGroupMultiUseMagicItems').prop('disabled', true).hide();
  $('#ItemValueGroupSingleUseMagicItems').prop('disabled', true).hide();
  $('#ItemValueGroupFood').prop('disabled', true).hide();

  $('#obj_metallic').parent().hide();
  $('#obj_two_handed').parent().hide();
  $('#obj_underwater_breath').parent().hide();
}

function setLightValueOptions() {
      if($('#LightInfinite').is(':checked')) {
        $('#LightInfiniteField').prop('disabled', false);
        $('#LightDeadField').prop('disabled', true);
        $('#LightHoursField').prop('disabled', true).val('-1');
      }
      if($('#LightDead').is(':checked')) {
        $('#LightInfiniteField').prop('disabled', true);
        $('#LightDeadField').prop('disabled', false);
        $('#LightHoursField').prop('disabled', true).val('0');
      }
      if($('#LightHours').is(':checked')) {
        $('#LightInfiniteField').prop('disabled', true);
        $('#LightDeadField').prop('disabled', true);
        $('#LightHoursField').prop('disabled', false);
      }
}

function setKeyValueOptions() {
  if( $('#ItemValueGroupContainer').find('#obj_v1').val() < 8 ) {
      $('#LocalKeyVnumField').prop('disabled', true);
      $('#ExternalKeyVnumField').prop('disabled', true);
      $('#BadKeyVnumField').prop('disabled', false);
      $('#LocalKeyVnumGroup').hide();
      $('#ExternalKeyVnumGroup').hide();
      $('#ContainerKeyVnumGroup').hide();
  } else {
    if( $('#ContainerKeyVnumGroup').is(":visible") ) {
      if($('#LocalKeyVnumRadio').is(':checked')) {
        $('#LocalKeyVnumField').prop('disabled', false);
        $('#ExternalKeyVnumField').prop('disabled', true);
        $('#BadKeyVnumField').prop('disabled', true);
        $('#LocalKeyVnumGroup').show();
        $('#ExternalKeyVnumGroup').hide();
      }
      if($('#ExternalKeyVnumRadio').is(':checked')) {
        $('#LocalKeyVnumField').prop('disabled', true);
        $('#ExternalKeyVnumField').prop('disabled', false);
        $('#BadKeyVnumField').prop('disabled', true);
        $('#LocalKeyVnumGroup').hide();
        $('#ExternalKeyVnumGroup').show();
      }
      if($('#BadKeyVnumRadio').is(':checked')) {
        $('#LocalKeyVnumField').prop('disabled', true);
        $('#ExternalKeyVnumField').prop('disabled', true);
        $('#BadKeyVnumField').prop('disabled', false);
        $('#LocalKeyVnumGroup').hide();
        $('#ExternalKeyVnumGroup').hide();
        $('#ContainerKeyVnumGroup').hide();
        $('#ItemValueGroupContainer').find('#obj_v1').val('5');
        $('#ItemValueGroupContainer').find('#obj_v2').val('0');
      }
    } else {
      $('#ContainerKeyVnumGroup').show()
      $('#LocalKeyVnumRadio').prop('checked', true);
      $('#LocalKeyVnumField').prop('disabled', false);
      $('#ExternalKeyVnumField').prop('disabled', true);
      $('#BadKeyVnumField').prop('disabled', true);
      $('#LocalKeyVnumGroup').show();
      $('#ExternalKeyVnumGroup').hide();
    }

  }
}

function setFormattedObjLdesc() {
  var text = $( '#obj_ldesc' ).val();
  if ($('#obj_evil').is(':checked') == true) text = "(Red Aura) " + text;
  if ($('#obj_good').is(':checked') == true) text = "(Blue Aura) " + text;
  if ($('#obj_invis').is(':checked') == true) text = "(Invis) " + text;
  if ($('#obj_hum').is(':checked') == true) text = "(Humming) " + text;
  if ($('#obj_glow').is(':checked') == true) text = "(Glowing) " + text;
  if ($('#obj_magic').is(':checked') == true) text = "(Magical) " + text;
  $('#formatted_ldesc').val(text);

}

function initObjForm() {
  setObjValues();
  setLightValueOptions();
  setKeyValueOptions();
  setFormattedObjLdesc();
  $('input').attr('autocomplete','off');
}