var beoneApp = angular.module('beone');

beoneApp.controller('WishCtrl', function($http, $scope, $sce) {
	
	$scope.wishes = [];
	$scope.wishToAdd = "";
	$scope.wishAddResultText = "";
	$scope.wishAddAlertClass = "";
	
	$http({
		method: 'GET',
		url: '/api/v1/wishes/'+userSelectedDateTransformed,
		headers: {
			'token':'TestToken'
		}
	}).success(function(result) {
		console.log("Wishes result returned");
		if(result.data == null || result.data.length == 0) {
			var wishItem = {
					wishText: "This is my wish..."
			};
			var wishItems = [];
			wishItems[0] = wishItem;
			$scope.wishes = wishItems;
		} else {
			$scope.wishes = result.data;
		}
	}).error(function(response, status) {
		console.log("Wishes error occured: " + response);
		console.log("status: " + status);
	});
	
	
	$scope.toggleModal = function() {
		$('#wishiesModal').modal({
			  keyboard: false
		});
	};
	
	$scope.addNewWish = function(wish, callback) {
        console.log("$scope.addNewWish called");
        
        if(wish.body == null || wish.body == "") {
        	alert("Wish cannot be empty");
        } else {
	        $http({
	            method: 'POST',
	            url: '/api/v1/wishes/',
	            data: {
	                "wishText": wish.body
	            },
	            headers: {
	                //'Content-Type': 'application/x-www-form-urlencoded',
	                'token': 'TestToken'
	            }
	        }).success(function (result) {
	            console.log("Wish item add result returned");
	            if (result == null || result.data == null || result.data.length == 0) {
	                //$scope.wishes.push(experience);
	                return callback(false, null);
	            } else {
	                $scope.wishes.push(result.data);
	                return callback(true, null);
	            }
	        }).error(function (response, status) {
	            console.log("addItem error occured: " + JSON.stringify(response));
	            console.log("status: " + status);
	
	            return callback(false, "Error occured");
	        });
        }
    };
    
    $scope.saveWish = function() {
    	console.log("$scope.saveWish called");
    	
    	var wish = {
			"body":$scope.wishToAdd
    	};
    	
    	$scope.addNewWish(wish, function(result, message) {
    		if(result == true) {
    			console.log("Provided wishyis saved");
    			$scope.wishToAdd = "";
    			$scope.wishAddResultText = "Wish added successfully";
    			$scope.wishAddAlertClass = "alert-success";
    		} else {
    			console.log("Wish could not be saved");
    			$scope.wishAddResultText = "There was an error during addition of wish";
    			$scope.wishAddAlertClass = "alert-danger";
    		}
    	});
    };
});
