// Facebook APP ID 1758970354388621
beoneApp.controller('ExperienceCtrl', function ($http, $scope, $routeParams, $timeout, ExperienceService) {
	// Init date
    $scope.experience = {};
    $scope.experiences = [];
	$scope.googleSearch = "";
	$scope.newExperienceText = "";
	$scope.experienceToAddOrEdit = {
		experienceDescription: "",
		experienceId: null,
		selectedIndex: null
	};
	

    $scope.addExperienceOnKeypress = function(event, newExperienceText, selectedDate){
		if (event.which === 13){
			$scope.addExperience(newExperienceText, selectedDate);
		}
	};
	
	$scope.getExperiencesOfDate = function(selectedDate){
    	ExperienceService.getExperiencesOfDate(selectedDate).then(
			function(result) {
				// Initilize experiences and remove previous entries
				$scope.experiences = [];
				
				var _experiences = result.slice();
				for(var i = 0; i < _experiences.length; i++){
					$scope.experiences[i] = {};
					$scope.experiences[i].experienceDescription = _experiences[_experiences.length - i - 1].experienceDescription.slice();
					$scope.experiences[i].experienceId = _experiences[_experiences.length - i - 1].userExperienceId;
				}
			},
			function(response) {
				//...
			}
		);
    };
	
	$scope.initExperience = function() {
		$scope.getExperiencesOfDate($scope.$parent.selectedDate);
    };
	
    // ##############################
    // Additional Functions
    // ##############################
    $scope.toggleModal = function(experience) {
    	$scope.experience = experience;
		$('#experienceModal').modal({
			  keyboard: false
		});
	};
	
    // ##############################
    // Functions called from the view
    // ##############################
	$scope.editItem = function (id) {
		var selectedBox = document.getElementById("experienceText" + id);
		selectedBox.removeAttribute("disabled");
	};

    $scope.addExperience = function (selectedDate) {
        if($scope.experienceToAddOrEdit.experienceDescription == "") {
        	alert("Experience cannot be empty");
        } else {
			if($scope.experienceToAddOrEdit.experienceId != 0 && $scope.experienceToAddOrEdit.experienceId) {
				ExperienceService.updateExperience($scope.experienceToAddOrEdit, selectedDate).then(
					function(result){
						/*
						var experienceDbObject = result;
						experienceDbObject.experienceDescription = $scope.experienceToAddOrEdit.experienceDescription;
						delete experienceDbObject.user;
						*/
						/*
						document.getElementById("experienceTextbox" + experienceIndexId).setAttribute("disabled", "disabled");
						var selectedItem = document.getElementById("experienceEditButton" + experienceIndexId);
						selectedItem.classList.remove("glyphicon-floppy-disk");
						selectedItem.classList.add("glyphicon-pencil");
						$scope.experiences[experienceIndexId].saveOrEdit = "edit";
						*/
						
						$scope.experiences[$scope.experienceToAddOrEdit.selectedIndex].experienceDescription = result.experienceDescription;
						
						$scope.experienceToAddOrEdit = {
							experienceDescription: "",
							experienceId: null,
							selectedIndex: null
						};
					}, 
					function(response){
						//...
					});
			} else {
				ExperienceService.addExperience($scope.experienceToAddOrEdit, selectedDate).then(
					function(result){
						var newExperience = {
							experienceId: result.userExperienceId,
							experienceDescription: $scope.experienceToAddOrEdit.experienceDescription
						}
						
						$scope.experiences.unshift(newExperience);
						var textArea = document.getElementById("experienceTextArea");
						textArea.value = "";
						$scope.experienceToAddOrEdit = {
							experienceDescription: "",
							experienceId: null
						};
					},
					function(){
						//...
					}
				);
			}
        }
    };

    $scope.deleteExperience = function (experience, experienceIndexId, edit) {
		if(edit){
			$scope.experiences.splice(experienceIndexId, 1);

			ExperienceService.deleteExperience(experience).then(
				function (result) {
				},
				function (response) {
					//...
				}
			);
		} else if(window.confirm("Delete experience?")) {
			ExperienceService.deleteExperience(experience).then(
				function (result) {
					$scope.experiences.splice(experienceIndexId, 1);
				},
				function (response) {
					//...
				}
			);
		} else {
			console.log("__0__ Deletion of experience canceled!");
		}
    };

    $scope.updateExperience = function (experience, selectedDate, experienceIndexId) {
		//$scope.newExperienceText = experience.experienceDescription.slice();
		//$scope.deleteExperience(experience, experienceIndexId, true);
		$scope.experienceToAddOrEdit = {
			experienceDescription: experience.experienceDescription,
			experienceId: experience.experienceId,
			selectedIndex: experienceIndexId
		}
		
		/*
		if( $scope.experiences[experienceIndexId].saveOrEdit === "edit" || !$scope.experiences[experienceIndexId].saveOrEdit ){
			var textarea = document.getElementById("experienceTextbox" + experienceIndexId);
			textarea.removeAttribute("disabled");
			textarea.focus();
			var selectedItem = document.getElementById("experienceEditButton" + experienceIndexId);
			selectedItem.classList.remove("fa fa-pencil-o");
			selectedItem.classList.add("glyphicon-floppy-disk");
			$scope.experiences[experienceIndexId].saveOrEdit = "save";
		} else {
			ExperienceService.updateExperience(experience, selectedDate).then(
				function(result){
					var experienceDbObject = result;
					experienceDbObject.experienceDescription = experience.experienceDescription;
					delete experienceDbObject.user;
					
					document.getElementById("experienceTextbox" + experienceIndexId).setAttribute("disabled", "disabled");
					var selectedItem = document.getElementById("experienceEditButton" + experienceIndexId);
					selectedItem.classList.remove("glyphicon-floppy-disk");
					selectedItem.classList.add("glyphicon-pencil");
					$scope.experiences[experienceIndexId].saveOrEdit = "edit";
				}, 
				function(response){
					//...
				}
			);
		}
		*/
    };
	$scope.$on('reloadAllCalendarEvents', function(event, args){
		$scope.initExperience();
	});
});