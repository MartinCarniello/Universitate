
  function datesPicker()	{
  	$('.js-datepicker').datepicker({
      format: 'dd/mm/yyyy'
    });

    $(".js-datepicker").inputmask("dd/mm/yyyy");
  }

  $(document).ready(datesPicker);
  $(document).on('turbolinks:load', datesPicker)
