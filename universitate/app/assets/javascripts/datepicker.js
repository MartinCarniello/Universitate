function dateInputs()	{
	$('.js-datepicker').datepicker({
    format: 'dd/mm/yyyy'
  });

  $(".js-datepicker").inputmask("dd/mm/yyyy");
}

$(document).ready(dateInputs);
