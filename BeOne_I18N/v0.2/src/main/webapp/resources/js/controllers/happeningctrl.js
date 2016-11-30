beoneApp.controller('HappeningCtrl', function($scope, $http, HappeningService) {
	$scope.happening = {};
	
	$scope.initHappenings = function() {
		$scope.getUserCalendarEvents();
	};

	$scope.$on('addHappeningsToUserCalendars',$scope.initHappenings);
	
	$scope.getUserCalendarEvents = function() {
		HappeningService.getUserCalendarEvents($scope.$parent.selectedDate).then(
	        function(result) {
				// Initilize userCalendarEvents and remove previous entries
				$scope.userCalendarEvents = [];
				
                var allUserCalendarEvents = result.slice();
				
				// Sort all calendar events
				allUserCalendarEvents.sort(function(eventA, eventB){
					var nameA = eventA.eventName.toLowerCase();
					var nameB = eventB.eventName.toLowerCase();
					if (nameA < nameB) //sort string ascending
						return -1 
					if (nameA > nameB)
						return 1
					return 0 //default return value (no sorting)
				});

                for(var i = 0; i < allUserCalendarEvents.length; i++) {
                    var flag = true;
					if($scope.userCalendarEvents){
						for( var j = 0; j < $scope.userCalendarEvents.length; j++ ) {
							if(Number($scope.userCalendarEvents[j].eventId) === Number(allUserCalendarEvents[i].eventId)) {
								flag = false;
							}
						}
					} else {
						$scope.userCalendarEvents = [];
					}
                    if(flag){
                            $scope.userCalendarEvents.push(allUserCalendarEvents[i]);
                    }
                }
				$scope.addHappeningsToCalendars();
	        },
	        function(response, status) {
	        	//...
	        }
		);
	};
	
	$scope.addHappeningsToCalendars = function(){
		for(var i = 0; i < $scope.$parent.userCalendars.length; i++){
			var happenings = [];
			for(var j = 0; j < $scope.userCalendarEvents.length; j++){
				if($scope.$parent.userCalendars[i].calendarId === $scope.userCalendarEvents[j].subCategory.calendar.calendarId){
					happenings.push($scope.userCalendarEvents[j]);
				}
			}
			$scope.$parent.userCalendars[i].happenings = happenings;
		}
	};
	
    $scope.resultInteract = function (result, obj) {
        $scope.experience = {};

        if (result == true) {
            console.log("Operation was successful");
	        alert("Successful");
        } else if (obj == null) {
            console.log("There was an error, no result retrieved");
            alert("Error occured");
        } else {
            console.log("There was an error: " + obj);
            alert("Error occured");
        }
    };
    
    // ##############################
    // Additional Functions
    // ##############################
    $scope.toggleModal = function(happening) {
    	$scope.happening = happening;
    	// $scope.googleSearch = happening.eventName.replace(/ /g, "+");
		$('#happeningModal').modal({
			  keyboard: false
		});
	};

	// Listens to $rootScope.$broadcast('reloadAllCalendarEvents') fired in profilectrl
	$scope.$on('reloadAllCalendarEvents', function(event, args){
		$scope.initHappenings();
	});
});