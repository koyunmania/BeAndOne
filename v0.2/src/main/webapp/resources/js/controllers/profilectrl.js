beoneApp.controller('ProfileCtrl', function($scope, $rootScope, $http, ProfileService) {
	$scope.profilePhoto = "";
	$scope.allCalendars = [];
	$scope.allCountries = [];
	$scope.selectedCalendars = [];
	$scope.selectedCountry = {};
	$scope.allCalendarSubcategories = [];
	$scope.selectedCalendarSubcategories = [];
	$scope.selectedCalendarSubcategories__ = [];
	$scope.checkboxValues = [];
	$scope.userCalendarSubCategories = [];
	$scope.selectAll = false;
	$scope.greeting = "";

    $scope.initProfile = function(){
		$scope.greeting();
		$scope.getAllCalendars($scope.getAllCalendarSubCategories, $scope.getUserCalendarSubCategories);
		$scope.getAllCountries($scope.getUserInformation);
	};
	
	$scope.selectCountry = function(country) {
		$scope.selectedCountry = country;
	};
	
	$scope.greeting = function(){
		var d = new Date();
		var h = d.getHours();
		if( ( h >= 20 && h < 24 ) || ( h >= 0 && h < 6 ) ){
			$scope.greeting = "Good Night";
		} else if( h >= 6 && h < 12 ){
			$scope.greeting = "Good Morning";
		} else if( h >= 12 && h < 17 ){
			$scope.greeting = "Good Afternoon";
		} else if( h >= 17 && h < 20 ){
			$scope.greeting = "Good Evening";
		} else {
			
		}
	}
	
	$scope.selectAllSubCategories = function(subCategories){
		for(var i = 0; i < subCategories.length; i++){
			if(!$scope.isSelected(subCategories[i])){
				$scope.selectedCalendarSubcategories.unshift(subCategories[i]);
				$scope.selectAll = true;
				// angular.element(document.getElementById("subCategoryCheckbox" + subCategories[i].subcategoryId)).trigger('click');
			}
		}
		$scope.selectAll = true;
	};
	
	$scope.isSelected = function(subCategory){
		for(var i = 0; i < $scope.selectedCalendarSubcategories.length; i++){
			if($scope.selectedCalendarSubcategories[i].subcategoryId === subCategory.subcategoryId){
				return true;
			}
		}
		return false;
	}
	
	$scope.isUserSubCategory = function(subCategory){
		var flag = false;
		for( var i = 0; i < $scope.userCalendarSubCategories.length; i++ ){
			if($scope.userCalendarSubCategories[i].beOneCalendarSubCategory.subcategoryId == subCategory.subcategoryId){
				flag = true;
			}
		}
		return flag;
	};
	
	$scope.getUserCalendarSubCategories = function(){
		ProfileService.getUserCalendarSubCategories().then(
			function(result){
				if(result == null || result.length == 0){
					$scope.userCalendarSubCategories = [];
					$scope.selectedCalendarSubcategories = [];
				} else {
					$scope.userCalendarSubCategories = result.slice();
					/*for(var i = 0; i < $scope.userCalendarSubCategories.length; i++){
						$scope.selectedCalendarSubcategories[i] = $scope.userCalendarSubCategories[i].beOneCalendarSubCategory;
					}*/
				}
			},
			function(response){
				//...
			}
		);
	};
	
	$scope.addToSelectedSubCategoryList = function(subCategory, index){
		var flag = false;
		if($scope.checkboxValues[index] === false){
			$scope.selectAll = false;
		}
		for( var i = 0; i < $scope.selectedCalendarSubcategories.length; i++ ){
			if($scope.selectedCalendarSubcategories[i].subcategoryId == subCategory.subcategoryId){
				flag = true;
				break;
			}
		}
		if(!flag){
			$scope.selectedCalendarSubcategories.unshift(subCategory);
		} else {
			for(var i = 0; i < $scope.selectedCalendarSubcategories.length; i++ ){
				if($scope.selectedCalendarSubcategories[i].subcategoryId == subCategory.subcategoryId){
					$scope.selectedCalendarSubcategories.splice(i, 1);
					i = i - 1;
				}
			}
		}
	};
	
	$scope.addUserCalendarSubCategories = function(index, calendarId){
		// Subscribe new selected subcategories
		if($scope.selectedCalendarSubcategories.length > 0){
			var toSubscribe = $scope.selectedCalendarSubcategories.slice();
		} else {
			var toSubscribe = [];
		}
		
		for(var i = 0; i < toSubscribe.length; i++){
			if($scope.isUserSubCategory(toSubscribe[i])){
				toSubscribe.splice(i, 1);
				i = i - 1;
			}
		}
		if( toSubscribe == null || toSubscribe.length === 0){
			console.log("__0__ Selected Subcategroies are already subscribed!");
		} else {
			ProfileService.addUserCalendarSubCategories(toSubscribe).then(
				function(result){
					for(var i = 0; i < toSubscribe.length; i++){
						$scope.userCalendarSubCategories.unshift({beOneCalendarSubCategory: toSubscribe[i]});
					}
				},
				function(response){
					//...
				}
			);
		}
		
		// Unsubscribe deselected subcategories
		if($scope.userCalendarSubCategories.length > 0){
			var toUnSubscribe = [];
			for(var i = 0; i < $scope.userCalendarSubCategories.length; i++){
				if($scope.userCalendarSubCategories[i].beOneCalendarSubCategory.calendar.calendarId === calendarId){
					toUnSubscribe.unshift($scope.userCalendarSubCategories[i].beOneCalendarSubCategory);
				}
			}
		} else {
			var toUnSubscribe = [];
		}

		for(var i = 0; i < toUnSubscribe.length; i++){
			var flag = false;
			for(var j = 0; j < $scope.selectedCalendarSubcategories.length; j++){
				if(toUnSubscribe[i].subcategoryId === $scope.selectedCalendarSubcategories[j].subcategoryId){
					flag = true;
				}
			}
			if(flag){
				toUnSubscribe.splice(i, 1);
				i = i - 1;
			}
		}
		if( toUnSubscribe == null || toUnSubscribe.length === 0){
			console.log("__0__ No subcategroies to unsubscribe!");
		} else {
			ProfileService.removeUserCalendarSubCategories(toUnSubscribe).then(
				function(result){
					for(var i = 0; i < toUnSubscribe.length; i++){
						for(var j = 0; j < $scope.userCalendarSubCategories.length; j++){
							if($scope.userCalendarSubCategories[j].beOneCalendarSubCategory.subcategoryId === toUnSubscribe[i].subcategoryId){
								$scope.userCalendarSubCategories.splice(j, 1);
								break;
							}
						}
					}
				},
				function(response){
					console.log();
				}
			);
		}
		// Requires revision
		$('#subCategoryModal' + index).modal('hide');
		$rootScope.$broadcast('reloadAllCalendarEvents', null);
	};
	
	$scope.getAllCalendarSubCategories = function(getUserCalendarSubCategories){
		ProfileService.getAllCalendarSubCategories().then(
			function(result){
				if(result == null || result.length == 0){
					$scope.allCalendarSubcategories = [];
				} else {
					$scope.allCalendarSubcategories = result.slice();
				}
				
				$scope.allCalendarSubcategories.sort(function(subCalA, subCalB){
					var nameA = subCalA.calendarSubCategory.toLowerCase();
					var nameB = subCalB.calendarSubCategory.toLowerCase();
					if (nameA < nameB) //sort string ascending
						return 1 
					if (nameA > nameB)
						return -1
					return 0 //default return value (no sorting)
				});

				
				for( var i = 0; i < $scope.allCalendarSubcategories.length; i++ ){
					for( var j = 0; j < $scope.allCalendars.length; j++ ){
						if( $scope.allCalendarSubcategories[i].calendar.calendarId === $scope.allCalendars[j].calendarId ) {
							if(!$scope.allCalendars[j].subCategories)
								$scope.allCalendars[j].subCategories = [];
							$scope.allCalendars[j].subCategories.unshift($scope.allCalendarSubcategories[i]);
						}
					}
				}
				
				getUserCalendarSubCategories();
			},
			function(response){
				getUserCalendarSubCategories();
			}
		);
	};
	
	$scope.getCalendarSubCategories = function(calendarId){
		ProfileService.getCalendarSubCategories(calendarId).then(
			function(result){
				if(result == null || result.length == 0){
					$scope.calendarSubcategory = [];
				} else {
					$scope.calendarSubcategory = result.slice();
				}
			},
			function(response){
				//..
			}
		);
	};
	
	$scope.getAllCalendars = function(getAllCalendarSubCategories, getUserCalendarSubCategories){
		ProfileService.getAllCalendars().then(
			function(result){
				if(result == null || result.length == 0){
					var allCalendars = [];
				} else {
					var allCalendars = result.slice();
				}
				
				allCalendars.sort(function(calA, calB){
					var orderA = calA.sortOrder;
					var orderB = calB.sortOrder;
					if (orderA < orderB) //sort string ascending
						return -1 
					if (orderA > orderB)
						return 1
					return 0 //default return value (no sorting)
				});
				for(var i = 0; i < allCalendars.length; i++){
					$scope.allCalendars.push(allCalendars[i]);
				}
				getAllCalendarSubCategories(getUserCalendarSubCategories);
			},
			function(response){
				//...
				getAllCalendarSubCategories(getUserCalendarSubCategories);
			}
		);
	};
		
	$scope.getAllCountries = function(getUserInformation){
		ProfileService.getAllCountries().then(
			function(result){
				if(result == null || result.length == 0){
					$scope.allCountries = [];
				} else {
					$scope.allCountries = result.slice();
				}
				getUserInformation();
			},
			function(response){
				getUserInformation();
			}
		);
	};
	
	$scope.getUserInformation = function(){
		ProfileService.getUserInformation().then(
			function(result){
				if(result == null || result.length == 0) {
					$scope.profile = {
						fullname:'Not Available',
						gender:'Not Available',
						birthday:'Not Available',
						currentCity:'Not Available',
						firstname: 'Not Available',
						lastname: 'Not Available'
					};
				} else {
					$scope.$parent.profile = result;
					$scope.$parent.profile.fullname = $scope.profile.firstname + " " + $scope.profile.lastname;
					
					var countries = $scope.allCountries;
					for( var i = 0; i < countries.length; i++ ) {
						for(var j=0; j<countries[i].cities.length; j++) {
							if($scope.profile.currentCity.cityId === countries[i].cities[j].cityId) {
								$scope.selectedCountry = countries[i];
								break;
							}
						}
					}
				}
			},
			function(response){
				//...
			}
		);
	};
	
	
	/**
	* This function is not used anymore. Calendars are managed individually with single buttons
	*/
	$scope.subscribeCalendars = function() {
		// Delete happening from calendar class for http request
		for( var i = 0; i < $scope.selectedCalendars.length; i++ ) {
			if($scope.selectedCalendars[i]) {
				$scope.selectedCalendars[i] = JSON.parse($scope.selectedCalendars[i]);
				if($scope.selectedCalendars[i].happenings) {
					delete $scope.selectedCalendars[i].happenings;
				}
			} else {
				$scope.selectedCalendars.splice(i, 1);
				i = i - 1;
			}
		}
		
		ProfileService.subscribeCalendars($scope.selectedCalendars).then(
			function(result){
				for( var i = 0; i < $scope.selectedCalendars.length; i++ ) {
					if($scope.selectedCalendars[i]) {
						$scope.$parent.userCalendars.unshift($scope.selectedCalendars[i]);
						//Remove registered calendar from allCalendars
						for(var j = 0; j < $scope.allCalendars.length; j++){
							if(Number($scope.allCalendars[j].calendarId) === Number($scope.selectedCalendars[i].calendarId)){
								$scope.allCalendars.splice(j, 1);
								j = j - 1;
							}
						}
					}
				}
				// Broadcast from rootScope to get all events new ##performance 
				$rootScope.$broadcast('reloadAllCalendarEvents', null);
				$('#registerCalendar').modal('hide');
			},
			function(response){
				//...
			}
		);
	};
	
	$scope.subscribeCalendar = function(calendar) {
		if(calendar.happening){
			delete calendar.happening;
		}
		ProfileService.subscribeCalendar(calendar).then(
			function(result){
				$scope.$parent.userCalendars.unshift(calendar);
				// Broadcast from rootScope to get all events new ##performance 
				$rootScope.$broadcast('reloadAllCalendarEvents', null);
			},
			function(response){
				//...
			}
		);
	};
	
	$scope.unsubscribeCalendar = function(calendar) {
		ProfileService.unsubscribeCalendar(calendar).then(
			function(result){
				for(var i = 0; i < $scope.$parent.userCalendars.length; i++){
					if( $scope.$parent.userCalendars[i].calendarId == calendar.calendarId ){
						$scope.$parent.userCalendars.splice(i, 1);
						i = i - 1;
					}
				}
			},
			function(response){
				//...
			}
		);
	};
	
	$scope.editProfile = function() {
		if( $scope.profile.saveOrEdit === "edit" || !$scope.profile.saveOrEdit ){
			var items = document.getElementsByClassName("profileLabel");
			for( var i = 0; i < items.length; i++ ) {
				items[i].classList.add("hidden");
			}
			items = document.getElementsByClassName("profileInput");
			for( var i = 0; i < items.length; i++ ) {
				items[i].classList.remove("hidden");
			}
			item = document.getElementById("profileButton");
			item.innerHTML = "Save";
			$scope.profile.saveOrEdit = "save";
		} else {
			ProfileService.editProfile($scope.profile).then(
				function(result){
					$scope.profileEditToSave();
				},
				function(response){
					//...
				}
			);
			
			/*
			if($scope.profilePhoto != "") {
				ProfileService.uploadProfilePhoto($scope.profilePhoto).then(
					function(result){
						$scope.profileEditToSave();
					},
					function(response){
						//...
					}
				);
			}
			*/
		}
	};
	$scope.profileEditToSave = function(){
		var items = document.getElementsByClassName("profileInput");
		for( var i = 0; i < items.length; i++ ) {
			items[i].classList.add("hidden");
		}
		items = document.getElementsByClassName("profileLabel");
		for( var i = 0; i < items.length; i++ ) {
			items[i].classList.remove("hidden");
		}
		item = document.getElementById("profileButton");
		item.innerHTML = "Edit";
		$scope.profile.saveOrEdit = "edit";
	};

	$scope.toggleModal = function() {
		$('#registerCalendar').modal({
			  keyboard: false
		});
		$('#registerCalendar').on('hidden.bs.modal', function () {
			$scope.selectedCalendars = [];
		});
	};

	$scope.isCalendarAUserCalendar = function(calendarId) {
		for( var j = 0; j < $scope.$parent.userCalendars.length; j++ ) {
			if(Number($scope.$parent.userCalendars[j].calendarId) === calendarId){
				return true;
			}
		}
		return false;
	}
	
	$scope.processMembership = function(calendar) {
		console.log("processMembership called with: " + JSON.stringify(calendar));
		if($scope.isCalendarAUserCalendar(calendar.calendarId)) {
			$scope.unsubscribeCalendar(calendar);
		} else {
			$scope.subscribeCalendar(calendar);
		}
	}
	
	$scope.openProfileModal = function() {
		$('#profileModal').modal({
			  keyboard: false
		});
	}
	$scope.openSubCategoryModal = function(calendar, index) {
		$scope.selectedCalendarSubcategories = [];
		$scope.selectAll = false;
		$scope.selectedCalendar = calendar;
		for(var i = 0; i < $scope.userCalendarSubCategories.length; i++){
			if($scope.userCalendarSubCategories[i].beOneCalendarSubCategory.calendar.calendarId === calendar.calendarId){
				$scope.selectedCalendarSubcategories.unshift($scope.userCalendarSubCategories[i].beOneCalendarSubCategory);
			}
		}
		
		$('#subCategoryModal' + index ).modal({
			  keyboard: false
		});
	}
});
