beoneApp.service('RootService', function($http, $q) {
	console.log("__1__ RootService initialized");
	
	var success = function(result, functionName, deferred) {
		// console.log("__1__ " + functionName + " result returned: " + JSON.stringify(result));
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

	this.getAllCalendars = function() {
		var deferred = $q.defer();
		$http({
			method: 'GET',
			url: '/api/v1/calendars'
		}).then(
			function(result){
				success(result, "getAllCalendars", deferred);
			},
			function(response, status){
				error(response, status, "getAllCalendars", deferred);
			}
		);
		return deferred.promise;
	};
});