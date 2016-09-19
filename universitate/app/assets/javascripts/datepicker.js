
  function datesPicker()	{
  	$('.datepicker').datepicker();
  }

  $(document).ready(datesPicker);
  $(document).on('turbolinks:load', datesPicker)
