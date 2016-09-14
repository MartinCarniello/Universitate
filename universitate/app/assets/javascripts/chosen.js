function chosenSubjects()	{
	// Chosen
	$(".chzn-select").chosen();
}

$(document).ready(chosenSubjects);
$(document).on('turbolinks:load', chosenSubjects)
