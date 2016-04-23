//$(document).on('change', '#select_all_checkboxes', function() {
//    $("input:checkbox").prop('checked', $(this).prop("checked"));
//});

$(document).ready(function(){

  $('#select_all_checkboxes').click(function() {
     $("input:checkbox").prop('checked', $(this).prop("checked"));
  });
   
});

