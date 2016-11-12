<script src="/resources/js/fileupload/jquery.iframe-transport.js"></script>
<script src="/resources/js/fileupload/jquery.fileupload.js"></script>

	<script>
	
	$(function () {
    $('#fileUpload').fileupload({
        dataType: 'json',
        options:{"headers": {
			'token':loginToken
		}},
		add: function (e, data) {
            data.context = $('#photoUploadButton')
				//.text('Upload')
                //.appendTo(document.body)
                .click(function () {
                    //data.context = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.submit();
                });
        },
        done: function (e, data) {
        	console.log("Result of upload: " + JSON.stringify(data));
        	
        	if(data._response.result.status == true) {
        		$('#photoUploadSuccess').css('display', 'block');
            	$('#photoUploadFailure').css('display', 'none');
        	} else {
        		$('#photoUploadFailure').css('display', 'block');
            	$('#photoUploadSuccess').css('display', 'none');
        	}
        },
        fail: function(e, data) {
        	$('#photoUploadFailure').css('display', 'block');
        	$('#photoUploadSuccess').css('display', 'none');
        },
		progressall: function (e, data) {
			var progress = parseInt(data.loaded / data.total * 100, 10);
			$('#progress .bar').css(
				'width',
				progress + '%'
			);
		}
    });
});
	</script>