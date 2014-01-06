$('form.file').submit(function(e) {
	var formObj = $(this);
	var formURL = formObj.attr("action");
	var formData = new FormData(this);

	$.ajax({
		url: formURL,
		type: 'POST',
		data: formData,
		mimeType: "multipart/form-data",
		contentType: false,
		cache: false,
		processData: false,
		success: function(data, textStatus, jqXHR) {
			// do something clever here
			loc = jqXHR.getResponseHeader('location');
			relativeUrl = $("<a href='" + loc + "'>").prop("pathname");
			alert("Image uploaded to " + relativeUrl)
		},
		error: function(jqXHR, textStatus, errorThrown) {
			// do something clever here
		}          
	});

    e.preventDefault();
});