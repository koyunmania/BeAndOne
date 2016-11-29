var beoneApp = angular.module('beone');

beoneApp.controller('HomeCtrl', function($http, $scope, $sce) {
	
	$http({
		method: 'GET',
		url: '/api/v1/experiences/'+userSelectedDate,
		headers: {
			'token':loginToken
		}
	}).success(function(result) {
		console.log("Experiences result returned");
		if(result == null || result.data == null || result.data.length == 0) {
			var experienceItem = {
				experienceDescription: "This is my experience..."
			};
			var experienceItems = [];
			experienceItems[0] = experienceItem;
			$scope.experiences = experienceItems;
		} else {
			$scope.experiences = result.data;
		}
	}).error(function(response, status) {
		console.log("Experiences error occured: " + response);
		console.log("status: " + status);
	});
});
