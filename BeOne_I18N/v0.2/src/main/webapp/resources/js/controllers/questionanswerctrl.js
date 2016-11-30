beoneApp.controller('QuestionAnswerCtrl', function($scope, QuestionAnswerService) {
	console.log("__1__ QuestionAnswerCtrl initialized");
	
	$scope.userAnswers = [];
	$scope.userAnswer = {};
	$scope.question = "";
	$scope.activeQuestions = [];
	$scope.whatIsYourWishQuestion = {
		foundAnswers:[],
		answerText: ""
	};
	$scope.nelerOgrendinQuestion = {
		foundAnswers:[],
		answerText: ""
	};
	$scope.yourMoodQuestion = {
		foundAnswers:[],
		answerText: ""
	};

	$scope.initQuestionAnswer = function(selectedDate){
		//$scope.getActiveQuestions();
		$scope.loadGivenAnswersForQuestionsOfDate(selectedDate);
	};
	
	$scope.deleteNelerOgrendinAnswer = function(userAnswer, answerIndex){
		if(window.confirm("Delete user answer?")){
			QuestionAnswerService.deleteUserAnswer(userAnswer).then(
				function (result) {
					$scope.nelerOgrendinQuestion.foundAnswers.splice(answerIndex, 1);
				},
				function (response) {
					//...
				}
			);
		} else {
			console.log("__0__ Deletion of user answer canceled!");
		}
	};
	
	$scope.deleteWhatIsYourWishAnswer = function(userAnswer, answerIndex){
		if(window.confirm("Delete user answer?")){
			QuestionAnswerService.deleteUserAnswer(userAnswer).then(
				function (result) {
					$scope.whatIsYourWishQuestion.foundAnswers.splice(answerIndex, 1);
				},
				function (response) {
					//...
				}
			);
		} else {
			console.log("__0__ Deletion of user answer canceled!");
		}
	};
	
	$scope.getUserAnswersForQuestion = function(){
		QuestionAnswerService.getUserAnswers().then(
			function(result){
				$scope.userAnswers = result.slice();
				for(var i = 0; i < $scope.activeQuestions.length; i++){
					for(var j = 0; j < result.length; j++){
						if($scope.activeQuestions[i].questionId === result[j].questionId){
							if(!$scope.activeQuestions[i].foundAnswers){
								$scope.activeQuestions[i].foundAnswers = [];
								$scope.activeQuestions[i].foundAnswers.unshift(result[j]);
							} else {
								$scope.activeQuestions[i].foundAnswers.unshift(result[j]);
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

//	$scope.getActiveQuestions = function(getUserAnswers){
//		QuestionAnswerService.getActiveQuestions().then(function(foundQuestions) {
//			$scope.activeQuestions = foundQuestions;
//			getUserAnswers();
//		}, function(){
//			console.log("Questions error occured: " + response);
//			console.log("status: " + status);
//		});
//	};
	
	$scope.loadGivenAnswersForQuestionsOfDate = function(selectedDate){
		QuestionAnswerService.loadGivenAnswersForGivenQuestionsAndDate(1, selectedDate).then(function(foundAnswers) {
			$scope.nelerOgrendinQuestion.foundAnswers = foundAnswers;
		}, function(){
			console.log("Questions error occured nelerOgrendinQuestion: " + response);
			console.log("status: " + status);
		});
		QuestionAnswerService.loadGivenAnswersForGivenQuestionsAndDate(2, selectedDate).then(function(foundAnswers) {
			$scope.whatIsYourWishQuestion.foundAnswers = foundAnswers;
		}, function(){
			console.log("Questions error occured whatIsYourWishQuestion: " + response);
			console.log("status: " + status);
		});
	};
	
	$scope.saveNelerOgrendinAnswer = function(userAnswerText, questionCode) {
		if(userAnswerText == null || userAnswerText == ""){
			alert("Answer cannot be empty");
		} else {
			QuestionAnswerService.saveAnswer(userAnswerText, questionCode).then(
					function(insertedAnswer) {
						console.log(JSON.stringify(insertedAnswer));
						$scope.nelerOgrendinQuestion.answerText = "";
						$scope.nelerOgrendinQuestion.foundAnswers.push(insertedAnswer);
				}, function(){
				}
			);
		}
	}
	
	$scope.saveWhatIsYourWishAnswer = function(userAnswerText, questionCode) {
		if(userAnswerText == null || userAnswerText == ""){
			alert("Answer cannot be empty");
		} else {
			QuestionAnswerService.saveAnswer(userAnswerText, questionCode).then(
					function(insertedAnswer) {
						console.log(JSON.stringify(insertedAnswer));
						$scope.whatIsYourWishQuestion.answerText = "";
						$scope.whatIsYourWishQuestion.foundAnswers.push(insertedAnswer);
				}, function(){
				}
			);
		}
	}

	$scope.$on('reloadAllCalendarEvents', function(event, args){
		$scope.initQuestionAnswer($scope.$parent.selectedDate);
	});

    $scope.toggleModal = function(userAnswer, e) {
		$scope.question = e.currentTarget.parentNode.parentNode.parentNode.parentNode.childNodes[1].innerHTML;
    	$scope.userAnswer = userAnswer;
		$('#answerModal').modal({
			  keyboard: false
		});
	};
	
	/**
	$scope.saveAnswer = function(userAnswerText, questionCode) {
		if(userAnswerText == null || userAnswerText == ""){
			alert("Answer cannot be empty");
		} else {
			QuestionAnswerService.saveAnswer(userAnswerText, questionCode).then(
					function() {
						$scope.nelerOgrendinQuestion.answerText = "";
						$scope.whatIsYourWishQuestion.answerText = "";
				}, function(){
					//..
				}
			);
		}
	}
	*/
});