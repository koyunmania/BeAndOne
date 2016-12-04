<!-- Footer -->
    <footer>
        <div class="container" style="text-align:center;">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="list-inline">
                        <li style="margin-right:30px;">
                            <a href="#">Hakkimizda</a>
                        </li>
                        <li>
                            <a href="#">Iletisim</a>
                        </li>
                    </ul>                    
                </div>
            </div>
        </div>
    </footer>

<script src="/resources/js/fileupload/jquery.iframe-transport.js"></script>
<script src="/resources/js/fileupload/jquery.fileupload.js"></script>
<!--<script src="js/stickynavbar.js"></script>-->

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
	
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-88378650-1', 'auto');
  ga('send', 'pageview');

</script>