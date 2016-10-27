var initAutocomplete = function() {
  var input = document.getElementById("js-location-input");
  if(input) {
    var autocomplete = new google.maps.places.Autocomplete(input);
    $(input).keydown(function(event){ if(event.keyCode == 13) { event.preventDefault(); } });

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place = autocomplete.getPlace();
      $(".js-full-address-attribute").val($(input).val());
      $(".js-lat-attribute").val(place.geometry.location.lat());
      $(".js-lng-attribute").val(place.geometry.location.lng());
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

var initReplyComment = function(selectors) {
  selectors.unbind("click").bind({
    click: function(event) {
      event.preventDefault();
      $(this).closest(".comment-body").find(".js-reply-form").removeClass("hidden");
    }
  });
}

var initSortRadios = function() {
  $('#js-distance-radio').click(function(){
    if ($(this).is(':checked')) {
      $('#js-location-input').prop('disabled', false);
    }
  });

  $('#js-rating-radio').click(function(){
    if ($(this).is(':checked')) {
      $('#js-location-input').prop('disabled', true);
    }
  });

  $('#js-no-sort-radio').click(function(){
    if ($(this).is(':checked')) {
      $('#js-location-input').prop('disabled', true);
    }
  });
};

$(document).ready(function() {
  $(".js-teacher-form").on("cocoon:after-insert", function() {
    dateInputs();
  });

  initAvatarUploader();
  initAutocomplete();
  initReplyComment($(".js-reply-comment"));
  initSortRadios();
})
