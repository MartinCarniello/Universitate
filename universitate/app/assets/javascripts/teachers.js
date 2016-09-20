$(document).ready(function() {
  $(".js-teacher-form").on("cocoon:after-insert", function() {
    dateInputs();
  });
})