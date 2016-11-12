// Facebook APP ID 1758970354388621
beoneApp.controller('ExperienceCtrl', function ($http, $scope, $routeParams, $timeout, ExperienceService) {
	// Init date
    $scope.experience = {};
    $scope.experiences = [];
	$scope.googleSearch = "";

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

    $scope.addExperience = function (newExperienceText, selectedDate) {
        if(newExperienceText == null || newExperienceText == "") {
        	alert("Experience cannot be empty");
        } else {
			var newExperience = { experienceDescription: newExperienceText };
        	ExperienceService.addExperience(newExperience, selectedDate).then(
        		function(result){
	            	newExperience.experienceId = result.userExperienceId;
	                $scope.experiences.unshift(JSON.parse(JSON.stringify(newExperience)));
					var textArea = document.getElementById("experienceTextArea");
					textArea.value = "";
        		},
        		function(){
        			//...
        		}
        	);
        }
    };

    $scope.deleteExperience = function (experience, experienceScopeId) {
		if(window.confirm("Delete experience?")){
			ExperienceService.deleteExperience(experience).then(
				function (result) {
					$scope.experiences.splice(experienceScopeId, 1);
				},
				function (response) {
					//...
				}
			);
		} else {
			console.log("__0__ Deletion of experience canceled!");
		}
    };

    $scope.updateExperience = function (experience, selectedDate, experienceScopeId) {
		if( $scope.experiences[experienceScopeId].saveOrEdit === "edit" || !$scope.experiences[experienceScopeId].saveOrEdit ){
			var textarea = document.getElementById("experienceTextbox" + experienceScopeId);
			textarea.removeAttribute("disabled");
			textarea.focus();
			var selectedItem = document.getElementById("experienceEditButton" + experienceScopeId);
			selectedItem.classList.remove("glyphicon-pencil");
			selectedItem.classList.add("glyphicon-floppy-disk");
			$scope.experiences[experienceScopeId].saveOrEdit = "save";
		} else {
			ExperienceService.updateExperience(experience, selectedDate).then(
				function(result){
					var experienceDbObject = result;
					experienceDbObject.experienceDescription = experience.experienceDescription;
					delete experienceDbObject.user;
					
					document.getElementById("experienceTextbox" + experienceScopeId).setAttribute("disabled", "disabled");
					var selectedItem = document.getElementById("experienceEditButton" + experienceScopeId);
					selectedItem.classList.remove("glyphicon-floppy-disk");
					selectedItem.classList.add("glyphicon-pencil");
					$scope.experiences[experienceScopeId].saveOrEdit = "edit";
				}, 
				function(response){
					//...
				}
			);
		}
    };
	$scope.$on('reloadAllCalendarEvents', function(event, args){
		$scope.initExperience();
	});
});