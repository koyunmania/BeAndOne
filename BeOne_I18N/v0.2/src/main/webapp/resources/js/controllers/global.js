var beoneApp = angular.module('beone', ['ngRoute', 'djds4rce.angular-socialshare'])
	.config(function($locationProvider){
	    $locationProvider.html5Mode(true).hashPrefix('!');
	})
	.run(function($FB, $location, $http){
//		if($location.search().token){
//			$http.defaults.headers.common.token = $location.search().token;
//		} else {
//			$http.defaults.headers.common.token = $location.search("token", true).$$hash.substring(7);
//		}
		
		$http.defaults.headers.common.token = loginToken;
		
		$FB.init('1758970354388621');
	});