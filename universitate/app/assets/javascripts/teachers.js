var initAutocomplete = function() {
  var input = document.getElementById("js-location-input");
  if(input) {
    var autocomplete = new google.maps.places.Autocomplete(input);
    $(input).keydown(function(event){ if(event.keyCode == 13) { event.preventDefault(); } });

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();
      $("#user_location_attributes_full_address").val($(input).val());
      $("#user_location_attributes_lat").val(place.geometry.location.lat());
      $("#user_location_attributes_lng").val(place.geometry.location.lng());
    });
  }
};

var initAvatarUploader = function() {
  $(".js-preview").on("change", function () {
    $(".js-avatar-form").submit();
  });

  $(".js-loader").on("click", function(){
    $(".js-preview").click();
  })
}

var initRating = function() {
  $('.js-rating-stars').rating();
}

$(document).ready(function() {
  $(".js-teacher-form").on("cocoon:after-insert", function() {
    dateInputs();
  });

  initAvatarUploader();
  initAutocomplete();
})
