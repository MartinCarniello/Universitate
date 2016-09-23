  initAutocomplete = function() {
    var input = document.getElementById("js-location-input");
    var autocomplete = new google.maps.places.Autocomplete(input);
    $(input).keydown(function(event){ if(event.keyCode == 13) { event.preventDefault(); } });

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();
      $("#user_location_attributes_full_address").val($(input).val());
      $("#user_location_attributes_lat").val(place.geometry.location.lat());
      $("#user_location_attributes_lng").val(place.geometry.location.lng());
    });
  };



  previewFile = function(){
    var preview = document.getElementById('preview');
    var file    = document.querySelector('input[type=file]').files[0];
    var reader  = new FileReader();

    reader.onloadend = function () {
        preview.src = reader.result;
        document.getElementById('image_to_load').setAttribute('value',file.name);
    }

     if (file) {
         reader.readAsDataURL(file);
     } else {
         preview.src = "";
     }
  };

$(document).ready(function() {
  $(".js-teacher-form").on("cocoon:after-insert", function() {
    dateInputs();
  });

  $(".js-preview").on("change", function () {
    previewFile();
  });

  $(".js-loader").on("click", function(){
    document.getElementById('loader').click();
  })

  initAutocomplete();
})
