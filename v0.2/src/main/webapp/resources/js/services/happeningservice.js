beoneApp.service('HappeningService', function($http, $q) {
	console.log("__1__ HappeningService initialized");
	
	var success = function(result, functionName, deferred) {
		if (result == null || result.data == null || result.data.length == 0) {
			console.log("__0__ " + functionName + " didn't return a value!");
			deferred.resolve([]);
		} else {
			deferred.resolve(result.data.data);
			console.log("__1__ " + functionName + " returned successfully...");
		}
	};
	var error = function(response, status, functionName, deferred) {
		console.log("__0__ " + functionName + " status: " + status);
		console.log("__0__ " + functionName + " error occured: " + JSON.stringify(response));
		deferred.reject("There is an error occured");
	};

	this.getUserCalendarEvents = function(selectedDate) {
		var deferred = $q.defer();
		$http({
	        method: 'GET',
	        url: '/api/v1/usercalendarevents/'+ selectedDate
		}).then(
			function(result){
				if(result.data.status == true)
					success(result, "getUserCalendarEvents", deferred);
				else
					error(result, null, "getUserCalendarEvents", deferred);
			},
			function(response, status){
				error(response, status, "getUserCalendarEvents", deferred);
			}
		);
		return deferred.promise;
	};
});