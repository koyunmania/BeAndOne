beoneApp.service('QuestionAnswerService', function($http, $q) {
	console.log("__1__ QuestionAnswerService initialized");
	
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

	this.deleteUserAnswer = function(userAnswer){
		var deferred = $q.defer();
		$http({
			method: 'DELETE',
			url: '/api/v1/answer/' + userAnswer.userAnswerId
		}).then(
			function(result){
				success(result, "deleteUserAnswer", deferred);
			},
			function(response){
				error(response, status, "deleteUserAnswer", deferred);
			}
		);
		return deferred.promise;
	};

		
	
	this.getUserAnswers = function(){
		var deferred = $q.defer();
		$http({
			method: 'DELETE',
			url: '/api/v1/answer/' + userAnswer.userAnswerId
		}).then(
			function(result){
				success(result, "deleteUserAnswer", deferred);
			},
			function(response){
				error(response, status, "deleteUserAnswer", deferred);
			}
		);
		return deferred.promise;
	};

		
	
	this.getActiveQuestions = function() {
		var deferred = $q.defer();
		$http({
			method : 'GET',
			url : '/api/v1/questions'
		}).then(
			function(result){
				success(result, "getActiveQuestions", deferred);
			},
			function(response, status){
				error(response, status, "getActiveQuestions", deferred);
			}
		);
		return deferred.promise;
	};
	
	this.loadGivenAnswersForGivenQuestionsAndDate = function(questionCode, selectedDate) {
		var deferred = $q.defer();
		$http({
			method : 'GET',
			url : '/api/v1/questionAnswers/'+questionCode+'/'+selectedDate
		}).then(
			function(result){
				success(result, "loadGivenAnswersForGivenQuestionsAndDate", deferred);
			},
			function(response, status){
				error(response, status, "loadGivenAnswersForGivenQuestionsAndDate", deferred);
			}
		);
		return deferred.promise;
	};

	this.saveAnswer = function(userAnswerText, questionCode) {
		var deferred = $q.defer();
		$http({
			method : 'POST',
			url : '/api/v1/answer',
			data: {
				//"userAnswerId": 1,
				"questionCode": questionCode,
				"userAnswerText": userAnswerText
				//"selectedAnswerId": 1,
				//"userId": 1			
			}
		}).then(
			function(result){
				success(result, "saveAnswer", deferred);
			},
			function(response, status){
				error(response, status, "saveAnswer", deferred);
			}
		);
		return deferred.promise;
	};
});