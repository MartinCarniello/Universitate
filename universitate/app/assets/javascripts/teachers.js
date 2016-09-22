  initAutocomplete = function() {
    var input = $("location-input");
    var autocomplete = new google.maps.places.Autocomplete(input);
    $(input).keydown(function(event){ if(event.keyCode == 13) { event.preventDefault(); } });

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();
      $("#incident_lat").val(place.geometry.location.lat())
      $("#incident_lng").val(place.geometry.location.lng())
    });
  };

$(document).ready(function() {
  $(".js-teacher-form").on("cocoon:after-insert", function() {
    dateInputs();
  });

  initAutocomplete();
})