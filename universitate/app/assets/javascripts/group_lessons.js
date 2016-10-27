var initialize_datetimepicker = function() {
  $('.js-datetimepicker').datetimepicker({
    format: 'DD-MM-YYYY HH:mm'
  });

  $('.js-datetimepicker').inputmask('datetime');
  $('.datetimepicker').inputmask("9999/99/99 99:99");
};

$(document).ready(function(){
  initialize_datetimepicker();
});
