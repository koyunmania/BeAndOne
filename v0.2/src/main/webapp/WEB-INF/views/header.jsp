<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Be&One</title>
    
    <!-- Bootstrap -->
    <!-- <link rel="stylesheet" href="/resources/css/bootstrap-3.2.0/bootstrap.min.css"/> -->
    <!-- <link rel="stylesheet" href="/resources/css/font-awesome-4.1.0/font-awesome.min.css"/> -->
	<!-- <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"> -->
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<script src="https://use.fontawesome.com/e1106744cc.js"></script>	
    <link rel="stylesheet" href="/resources/css/BootSideMenu.css">
    <link rel="stylesheet" href="/resources/css/beonestyle.css">
    <link rel="stylesheet" href="/resources/css/bootstrap-datepicker-1.5.0/bootstrap-datepicker.css">
	<link rel="stylesheet" href="/resources/css/nanoscroller.css">

    <style type="text/css">
        .user {
            padding: 5px;
            margin-bottom: 5px;
        }
		
		.nano { height: 100px; }
    </style>
	
	<script type="text/javascript">
		var userSelectedDate = "${selectedDate}";
		var splittedSelectedDate = userSelectedDate.split(/\-/);
		var userSelectedDateTransformed = ""+
			splittedSelectedDate[2] + "-" +
			splittedSelectedDate[1] + "-" +
			splittedSelectedDate[0];
		
		/* function init()
		{
			var windowUrl = window.location.href;
			var localIndex = 0;
			if(null!=windowUrl)
			{
				var localeDetail = windowUrl.indexOf("&")!=-1 ? windowUrl.substring(windowUrl.indexOf("?"), windowUrl.indexOf("&")) : windowUrl.substring(windowUrl.indexOf("?"), windowUrl.length);
				var localeDropdown = document.getElementById("locale");
				var dropDownLen = document.getElementById("locale").options.length;
				if(null!=localeDropdown && dropDownLen>0)
				{
					for(var i=0;i<dropDownLen;i++)
					{
						if(localeDetail.indexOf(localeDropdown.options[i].value)!=-1)
						{
							localeIndex = i;
							break;
						}
					}
				}
			}
			document.getElementById("locale").options.selectedIndex = localeIndex;
		} */
		
		/*
		function translatePageLang(pageLocale)
		{
			if(null!=pageLocale && null!=document.getElementById(pageLocale))
			{
				if(document.getElementById(pageLocale).selectedIndex==0)
				{
					window.open("http://localhost:8080/home?lang=en", "_self")
				}
				else
				{
					window.open("http://localhost:8080/home?lang=tr", "_self")
				}
			}			
		}
		*/
	</script>
    
    <!-- Latest compiled and minified JavaScript -->
	<script src="/resources/js/jquery-2.1.1/jquery-2.1.1.min.js"></script>
	<script src="/resources/js/bootstrap-3.2.0/bootstrap.min.js"></script>
	<script src="/resources/js/angularjs-1.2.22/angular.js"></script>
	<script src="/resources/js/angularjs-1.2.22/angular-route.js"></script>
	<script src="/resources/js/angularjs-1.2.22/angular-animate.js"></script>
	<script src="/resources/js/angularjs-1.2.22/angular-translate.js"></script>		
	
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