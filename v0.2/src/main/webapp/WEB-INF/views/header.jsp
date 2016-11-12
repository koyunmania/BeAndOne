<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Be-One-Now</title>
    
    <!-- Bootstrap -->
    <link rel="stylesheet" href="/resources/css/bootstrap-3.2.0/bootstrap.min.css"/>
    <!-- <link rel="stylesheet" href="/resources/css/font-awesome-4.1.0/font-awesome.min.css"/> -->
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/BootSideMenu.css">
    <link rel="stylesheet" href="/resources/css/beonestyle.css">
    <link rel="stylesheet" href="/resources/css/bootstrap-datepicker-1.5.0/bootstrap-datepicker.css">

    <style type="text/css">
        .user {
            padding: 5px;
            margin-bottom: 5px;
        }
    </style>
	
	<script type="text/javascript">
		var userSelectedDate = "${selectedDate}";
		var splittedSelectedDate = userSelectedDate.split(/\-/);
		var userSelectedDateTransformed = ""+
			splittedSelectedDate[2] + "-" +
			splittedSelectedDate[1] + "-" +
			splittedSelectedDate[0];
	</script>
    
    <!-- Latest compiled and minified JavaScript -->
	<script src="/resources/js/jquery-2.1.1/jquery-2.1.1.min.js"></script>
	<script src="/resources/js/bootstrap-3.2.0/bootstrap.min.js"></script>
	<script src="/resources/js/angularjs-1.2.22/angular.js"></script>
	<script src="/resources/js/angularjs-1.2.22/angular-route.js"></script>
	<script src="/resources/js/angularjs-1.2.22/angular-animate.js"></script>
	
	<script type="text/javascript">
		angular.module('beone', [])
			.filter('unsafe', function($sce) {
				return function(val) {
					return $sce.trustAsHtml(val);
				};
		});
		
		var loginToken = "<%=request.getParameter("token")%>";
	</script>
	
	<script src="/resources/js/facebookSDK/angular-socialshare.js"></script>
	<script src="/resources/js/facebookSDK/twitter_widgets.js"></script>
	<script src="/resources/js/controllers/global.js"></script>

	<script src="/resources/js/services/questionanswerservice.js"></script>
    <script src="/resources/js/services/happeningservice.js"></script>
    <script src="/resources/js/services/profileservice.js"></script>
    <script src="/resources/js/services/experienceservice.js"></script>
    <script src="/resources/js/services/rootservice.js"></script>
    	
	<script src="/resources/js/controllers/rootctrl.js"></script>
    <script src="/resources/js/controllers/homectrl.js"></script>
    <script src="/resources/js/controllers/experiencectrl.js"></script>
    <script src="/resources/js/controllers/happeningctrl.js"></script>
    <script src="/resources/js/controllers/wishctrl.js"></script>
    <script src="/resources/js/controllers/dailyctrl.js"></script>
    <script src="/resources/js/controllers/profilectrl.js"></script>
    <script src="/resources/js/controllers/questionanswerctrl.js"></script>
    
	<script src="/resources/js/jquery-ui-1.11.2/jquery-ui.js"></script>
	<script src="/resources/js/bootstrap-datepicker.js"></script>
    
    <!-- <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>-->
    <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script> -->
    
    <script src="/resources/js/BootSideMenu.js"></script>

</head>