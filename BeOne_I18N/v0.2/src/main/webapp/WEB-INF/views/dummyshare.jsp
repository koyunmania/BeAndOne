
<html data-ng-app="facebookShareApp">
  <head>
	<%@include file="header.jsp"%>
    <link rel='stylesheet' href="/resources/js/facebookSDK/angular-socialshare.css">
	<script src="/resources/js/facebookSDK/angular-socialshare.js"></script>
	<script src="/resources/js/facebookSDK/angular-socialshare_script.js"></script>
  </head>

  <body>
    <div data-ng-controller="facebookShareController" class="container">
		 <a facebook class="fa fa-facebook btn btn-primary btn-facebook" data-url='http://google.com' data-shares='shares'>{{ shares }}</a>
	</div>
    
  </body>

</html>
