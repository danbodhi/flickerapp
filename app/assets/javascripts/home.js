$("#photo_search").submit(function() {
	$.post($(this).attr('action') + '.js', $(this).serialize(), null, "script");
	return false;
});