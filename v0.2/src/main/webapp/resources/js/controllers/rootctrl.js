// Facebook APP ID 1758970354388621
beoneApp.controller('RootCtrl', function ($http, $scope, $routeParams, $timeout, $rootScope, RootService) {
	// Init date
	var currentDate = new Date();
	
    $scope.selectedDate = ""+
		(currentDate.getDate() < 10 ? ("0" + currentDate.getDate()) : (currentDate.getDate())) + "-" +
		(currentDate.getMonth() < 9 ? ("0"+(currentDate.getMonth() + 1)) : (currentDate.getMonth() + 1)) + "-"+
		currentDate.getFullYear();

	$scope.userCalendars = [];
	$scope.userCalendarEvents = [];
	$scope.greeting = "";
	
	$scope.profile = {
		fullname:'N/A',
		gender:'N/A',
		birthday:'N/A',
		currentCity:'N/A',
		firstname: 'N/A',
		lastname: 'N/A'
	};
	
	var localScope = $scope;
	
	$scope.initRoot = function(){
		$scope.getUserCalendars();
	};
	
    //Date picker
	$('#calendarContainer div').datepicker({
		'format':'dd-mm-yyyy',
		'todayBtn': true,
		'weekStart':1,
		'todayHighlight': true,
		'autoclose': true,
		"isInline": true
	}).on('changeDate', function(e) {
		console.log("Selected date: "+JSON.stringify(e.date));
		if(e != null) {
			var d = new Date();
			var selectedDate = e.date;
			var year = selectedDate.getFullYear();
			var month = selectedDate.getMonth();
			month++;
			var day = selectedDate.getDate();
			var selectedDate = 
				(day < 10 ? "0"+day : day) + 
				"-" + (month < 10 ? "0"+month : month) + 
				"-" + year;

			if(!$(e.target).hasClass('birthday')) {
				localScope.selectedDate = selectedDate;
				localScope.$apply();
				$rootScope.$broadcast('reloadAllCalendarEvents', null);
			}
		}
	});
	
	$scope.getUserCalendars = function(){
		RootService.getAllCalendars().then(
			function(result){
				//Sort user calendars
				result.sort(function(calA, calB){
					var nameA = calA.calendarName.toLowerCase();
					var nameB = calB.calendarName.toLowerCase();
					if (nameA < nameB) //sort string ascending
						return -1 
					if (nameA > nameB)
						return 1
					return 0 //default return value (no sorting)
				});
				$scope.userCalendars = result.slice();
				// $scope.$broadcast('addHappeningsToUserCalendars', null);
				// $scope.$apply();
			},
			function(response){
				//...
			}
		);
	};
	
	$scope.$on('reloadAllCalendarEvents', function(event, args){
		$scope.initRoot();
	});
	
	$scope.convertToReadabledDate = function(formattedDate) {
		var currentDate = new Date();
	
		var converted = ""+
			currentDate.getDate() + " " + getMonthName(currentDate.getMonth()) + " "+currentDate.getFullYear();
			
		return converted;
	}
	
	function getMonthName(monthIndex) {
		switch(monthIndex) {
		case 0:
			return "Ocak";
			break;
		case 1:
			return "Subat";
		case 2:
			return "Mart";
		case 3:
			return "Nisan";
		case 4:
			return "Mayis";
		case 5:
			return "Haziran";
		case 6:
			return "Temmuz";
		case 7:
			return "Agustos";
		case 8:
			return "Eylül";
		case 9:
			return "Ekim";
		case 10:
			return "Kasim";
		case 11:
			return "Aralik";
		default:
			return (currentDate.getMonth() < 9 ? ("0"+(currentDate.getMonth() + 1)) : (currentDate.getMonth() + 1));
		}
	}
});