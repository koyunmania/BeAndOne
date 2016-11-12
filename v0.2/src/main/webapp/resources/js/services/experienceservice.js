beoneApp.service('ExperienceService', function($http, $q) {
	console.log("__1__ ExperienceService initialized");
	
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

	this.getExperiencesOfDate = function(selectedDate) {
		var deferred = $q.defer();
		$http({
			method: 'GET',
			url: '/api/v1/experiences/'+ selectedDate
		}).then(
			function(result){
				success(result, "getExperiencesOfDate", deferred);
			},
			function(response, status){
				error(response, status, "getExperiencesOfDate", deferred);
			}
		);
		return deferred.promise;
	};

	this.addExperience = function(experience, selectedDate) {
		var deferred = $q.defer();
		$http({
            method: 'POST',
            url: '/api/v1/experiences/',
            data: {
                "experienceDescription": experience.experienceDescription,
				"userExperienceId": experience.experienceId,
				"experienceDate": selectedDate
            }
		}).then(
			function(result){
				success(result, "addExperience", deferred);
			},
			function(response, status){
				error(response, status, "addExperience", deferred);
			}
		);
		return deferred.promise;
	};
	
	this.deleteExperience = function(experience) {
		var deferred = $q.defer();
		$http({
			method: 'DELETE',
			url: '/api/v1/experiences/?experienceId=' + experience.experienceId
		}).then(
			function(result){
				success(result, "deleteExperience", deferred);
			},
			function(response, status){
				error(response, status, "deleteExperience", deferred);
			}
		);
		return deferred.promise;
	};

	this.updateExperience = function(experience, selectedDate) {
		var deferred = $q.defer();
		$http({
    		method: 'POST',
    		url: "/api/v1/experiences",
            data: {
                "experienceDescription": experience.experienceDescription,
				"userExperienceId": experience.experienceId,
				"experienceDate": selectedDate
            }
		}).then(
			function(result){
				success(result, "updateExperience", deferred);
			},
			function(response, status){
				error(response, status, "updateExperience", deferred);
			}
		);
		return deferred.promise;
	};
});