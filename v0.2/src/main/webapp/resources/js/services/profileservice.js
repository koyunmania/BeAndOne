beoneApp.service('ProfileService', function($http, $q) {
	console.log("__1__ ProfileService initialized");
	
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
	
	this.getUserCalendarSubCategories = function() {
		var deferred = $q.defer();
		$http({
			method: 'GET',
			url: '/api/v1/usercalendarsubcategories/',
		}).then(
			function(result){
				success(result, "getUserCalendarSubCategories", deferred);
			},
			function(response, status){
				error(response, status, "getUserCalendarSubCategories", deferred);
			}
		);
		return deferred.promise;
	};

	this.removeUserCalendarSubCategories = function(unSelecetedSubCategories) {
		var deferred = $q.defer();
		$http({
			method: 'POST',
			url: '/api/v1/removeUserCalendarSubCategories/',
			data: unSelecetedSubCategories
		}).then(
			function(result){
				success(result, "removeUserCalendarSubCategories", deferred);
			},
			function(response, status){
				error(response, status, "removeUserCalendarSubCategories", deferred);
			}
		);
		return deferred.promise;
	};

	this.addUserCalendarSubCategories = function(selecetedSubCategories) {
		var deferred = $q.defer();
		$http({
			method: 'POST',
			url: '/api/v1/addusercalendarsubcategories/',
			data: selecetedSubCategories
		}).then(
			function(result){
				success(result, "addUserCalendarSubCategories", deferred);
			},
			function(response, status){
				error(response, status, "addUserCalendarSubCategories", deferred);
			}
		);
		return deferred.promise;
	};

	this.getAllCalendarSubCategories = function() {
		var deferred = $q.defer();
		$http({
			method: 'GET',
			url: '/api/v1/allcalendarsubcategories/'
		}).then(
			function(result){
				success(result, "getAllCalendarSubCategories", deferred);
			},
			function(response, status){
				error(response, status, "getAllCalendarSubCategories", deferred);
			}
		);
		return deferred.promise;
	};

	this.getCalendarSubCategories = function(calendarId) {
		var deferred = $q.defer();
		$http({
			method: 'GET',
			url: '/api/v1/calendarsubcategories/?calendarId=' + calendarId
		}).then(
			function(result){
				success(result, "getCalendarSubcategories", deferred);
			},
			function(response, status){
				error(response, status, "getCalendarSubcategories", deferred);
			}
		);
		return deferred.promise;
	};
/*
	this.getUserCalendars = function() {
		var deferred = $q.defer();
		$http({
			method: 'GET',
			url: '/api/v1/usercalendars'
		}).then(
			function(result){
				success(result, "getUserCalendars", deferred);
			},
			function(response, status){
				error(response, status, "getUserCalendars", deferred);
			}
		);
		return deferred.promise;
	};
*/	
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
	
	this.getAllCountries = function() {
		var deferred = $q.defer();
		$http({
			method: 'GET',
			url: '/api/v1/countries/'
		}).then(
			function(result){
				success(result, "getAllCountries", deferred);
			},
			function(response, status){
				error(response, status, "getAllCountries", deferred);
			}
		);
		return deferred.promise;
	};
	
	this.getUserInformation = function() {
		var deferred = $q.defer();
		$http({
			method: 'GET',
			url: '/api/v1/users/'
		}).then(
			function(result){
				success(result, "getUserInformation", deferred);
			},
			function(response, status){
				error(response, status, "getUserInformation", deferred);
			}
		);
		return deferred.promise;
	};
/*	
	this.subscribeCalendars = function(selectedCalendars) {
		var deferred = $q.defer();
		$http({
			method: 'POST',
			url: '/api/v1/usercalendars',
			data: selectedCalendars
		}).then(
			function(result){
				success(result, "subscribeCalendars", deferred);
			},
			function(response, status){
				error(response, status, "subscribeCalendars", deferred);
			}
		);
		return deferred.promise;
	};
	
	this.subscribeCalendar = function(selectedCalendar) {
		console.log("ProfileService.subscribeCalendar called with: " + JSON.stringify(selectedCalendar));
		var calendarArray =  [];
		calendarArray.push(selectedCalendar);
		var deferred = $q.defer();
		
		$http({
			method: 'POST',
			url: '/api/v1/usercalendars',
			data: calendarArray
		}).then(
			function(result){
				success(result, "subscribeCalendars", deferred);
			},
			function(response, status){
				error(response, status, "subscribeCalendars", deferred);
			}
		);
		return deferred.promise;
	};
	
	this.unsubscribeCalendar = function(calendar) {
		var deferred = $q.defer();
		$http({
			method: 'DELETE',
			url:'/api/v1/usercalendars/?calendarId=' + calendar.calendarId
		}).then(
			function(result){
				success(result, "unsubscribeCalendar", deferred);
			},
			function(response, status){
				error(response, status, "unsubscribeCalendar", deferred);
			}
		);
		return deferred.promise;
	};
*/	
	this.editProfile = function(profile) {
		var deferred = $q.defer();
		$http({
			method: "POST",
			url: "/api/v1/users/",
			data: {
				"firstname": profile.firstname,
				"lastname": profile.lastname,
				"username": profile.username,
				"gender": profile.gender,
				"birthday": profile.birthday,
				"currentCityId": profile.currentCity.cityId }
		}).then(
			function(result){
				success(result, "editProfile", deferred);
			},
			function(response, status){
				error(response, status, "editProfile", deferred);
			}
		);
		return deferred.promise;
	};
	
	/*
	this.uploadProfilePhoto = function(photo) {
		var deferred = $q.defer();
		$http({
			method: "POST",
			url: "/api/v1/users/",
			data: {}
		}).then(
			function(result){
				success(result, "editProfile", deferred);
			},
			function(response, status){
				error(response, status, "editProfile", deferred);
			}
		);
		return deferred.promise;
	};
	*/
});