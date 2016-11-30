<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page session="false"%>
<%@include file="header.jsp"%>

<!--  angular social share includes -->
<link rel='stylesheet'
	href="/resources/js/facebookSDK/angular-socialshare.css">

<body onLoad="init();window.scroll(0, 170)">
	<div ng-app="beone" ng-controller="RootCtrl" ng-init="initRoot()" class="container-fluid">
		<div class="row">
			<div class="title-page col-md-12">
				<div class="b-logo">
					<span>B</span>
				</div>
				<div class="mood">
					<h3><spring:message code="label.home.cover.howisyourmood" /></h3>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Awesome" href=''>&#x1F603</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Good" href=''>&#x1F60A</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Neutral" href=''>&#x1F614</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Sad" href=''>&#x1F615</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Frustrated" href=''>&#x1F627</a>
				</div>
				<div class="instagram fa fa-instagram">
					@benowmehere
				</div>
			</div>
			<div class="col-md-2">
				<%@include file="leftmenu.jsp"%>
			</div>
			<div class="col-md-10">
				<div class="row">
					<div class="col-md-7" ng-controller="HappeningCtrl" ng-init="initHappenings()">
						<h2 id="happenings-header">Bugunkuler</h2>
						<div ng-repeat="calendar in $parent.userCalendars">
							<div class="row panel panel-body" ng-repeat="happening in calendar.happenings" style="{{calendar.colorCode}}; font-size:40px; box-shadow: 5px 5px 15px rgba(0,0,0,0.1);">
								<div style="{{calendar.colorCode}}" class="col-md-2"><span class="{{calendar.calendarIcon}}" style="font-family:beone-font,'Glyphicons Halflings'"></span></div>
								<div class="col-md-7">
									<span style="{{calendar.colorCode}} font-size:20px; vertical-align:middle">
										<label>{{happening.eventName}}</label>
									</span><br/>
									<span style="{{calendar.colorCode}} font-size:12px; vertical-align:middle">
										<label>{{happening.subCategory.calendarSubCategory}}</label>
									</span>
								</div>
								<div class="col-md-3" style="text-align:right;">
									<button type="button" class="btn btn-success" ng-click="toggleModal(happening)">+C</button>
									<a href="https://www.google.com/search?q={{happening.eventName}}"
											target="_blank" class="btn btn-default btn-google"><img style="display: inline; margin-top: 2px;"
											src="../../resources/images/google-icon.svg" height="14px" /></a> 
								</div>
							</div>
						</div>

						<div id="happeningModal" class="modal fade" role="dialog">
							<div class="modal-dialog" style="width: 430px;">
								<!-- Modal content-->
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title happening">{{happening.eventName}}</h4> 
									</div>
									<div class="modal-body happening"
										style="min-height: 300px; background-repeat: no-repeat;">
										<!-- <div style="height: 40px;"></div>
										{{happening.eventDescription}}-->
										<img class="img-responsive" src="/api/v1/plusc/photo/{{happening.eventHappeningPhotoFilename}}"/>
									</div>
									<div class="modal-footer">
										<a facebook-feed-share class="fa fa-facebook btn btn-primary btn-facebook"
											data-url='beandone.com'
											data-shares='shares'
											data-picture=''
											data-name={{happening.eventName}}
											data-description={{happening.eventDescription}}
											data-caption='beandone.com'>{{shares}}
										</a>
										<a id="twitterButton" 
											class="btn-twitter"
											twitter data-lang="en"
											data-count='horizontal' 
											data-url='http://beandone.com'
											data-via='' 
											data-size="medium"
											data-text={{happening.eventName}}></a>
										<!-- <div class="fa fa-twitter btn btn-primary btn-twitter" ng-click="twitterClick($event)">
												<a id="twitterButton" style="display: none;" twitter data-lang="en" data-count='horizontal' data-url='http://google.com' data-via='notsosleepy' data-size="medium" data-text='Testing Twitter Share' ></a>
											</div> -->
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-5">
						<h2 id="experiences-header">Positif Gunluk</h2>
						<div class="panel panel-default" ng-controller="ExperienceCtrl" ng-init="initExperience()" style="background: url('/resources/images/beandone_questions_background.png') no-repeat; moz-background-size: cover; -moz-background-size: cover; border:0px; padding-left:25px;">
							<div class="panel-heading" style="border:0px; background-color:initial !important;">Bug&uuml;n ne gibi g&uuml;zellikler yasadin?</div>
							<div class="panel-body">
							<c:if test="${usersCurrentDate.equals(selectedDate)}">
								<form>
									<textarea class="form-control" rows="1" id="experienceTextArea" cols="30"
										ng-model="newExperienceText"
										ng-keypress="addExperienceOnKeypress($event, newExperienceText, selectedDate)"></textarea>
									<br />
									<button class="btn btn-default" type="submit"
										ng-click="addExperience(newExperienceText, selectedDate)">Save</button>
								</form>
							</c:if>
								<div style="overflow-y:scroll; overflow-x:hidden; height:100px;">
									<div ng-repeat="exper in experiences track by exper.experienceId" class="row" style="margin-bottom:15px;">
										<div style="border-bottom-width:2px; border-bottom-style:solid; border-bottom-color:#AAA;padding-bottom:10px;min-height:85px; max-width:400px;">
											<div class="col col-lg-9 experienceText">
											{{exper.experienceDescription}}
											</div>
											<div class="col col-lg-3" style="text-align:right;padding-right:5px;">
												<div class="row">
													<div class="col-lg-12" style="padding-left:10px;">
														<button type="button" id="experienceEditButton{{$index}}" class="btn btn-small btn-info glyphicon glyphicon-pencil" ng-click="updateExperience(exper, $index)"></button>
														<button type="button" id="experienceDeleteButton{{$index}}" class="btn btn-small btn-danger glyphicon glyphicon-trash" ng-click="deleteExperience(exper, $index)"></button>
													</div>
												</div>
												<div class="row" style="margin-top:5px;">
													<div class="col-lg-12" style="padding-left:10px;">
														<button type="button" ng-click="toggleModal(exper)" class="btn btn-block btn-default">+C</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div id="experienceModal" class="modal fade" role="dialog">
								<div class="modal-dialog" style="width: auto">
									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title happening">Guzellikleri paylas</h4> 
										</div>
										<div class="modal-body happening"
											style="min-height: 300px; background-repeat: no-repeat;">
											<div style="height: 40px;"></div>
											{{happening.eventDescription}}
										</div>
										<div class="modal-footer">
											<a facebook-feed-share class="fa fa-facebook btn btn-primary btn-facebook"
												data-url='beandone.com'
												data-shares='shares'
												data-picture=''
												data-name={{experience.experienceDescription}}
												data-description=""
												data-caption='beandone.com'>{{shares}}
											</a>
											<a id="twitterButton" 
												class="btn-twitter"
												twitter data-lang="en"
												data-count='horizontal' 
												data-url='http://beandone.com'
												data-via='' 
												data-size="medium"
												data-text={{experience.experienceDescription}}></a>
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<h2 id="experiences-header">G&uuml;nl&uuml;k Sorular</h2>
						<div id="myCarousel" class="carousel slide" data-interval="false">
							<div ng-controller="QuestionAnswerCtrl" ng-init="initQuestionAnswer('${selectedDate}')" class="carousel-inner" role="listbox">
								<div class="item panel panel-default active" style="background: url('/resources/images/beandone_questions_background.png') no-repeat; moz-background-size: cover; -moz-background-size: cover; border:0px; padding-left:25px;">
									<div class="panel-heading" style="border:0px; background-color:initial !important;">Bugun neler ogrendin?
										<a href="#myCarousel" role="button" data-slide="next" style="float:right;margin-right:5px;">
											<span>&gt;&gt;</span>
										</a>
										<a href="#myCarousel" role="button" data-slide="prev" style="float:right;margin-right:5px;">
											<span>&lt;&lt;</span>
										</a>
									</div>
									<div class="panel-body">
									<c:if test="${usersCurrentDate.equals(selectedDate)}">
										<form>
											<textarea class="form-control" rows="2" cols="30"
												ng-model="nelerOgrendinQuestion.answerText"></textarea>
											<br />
											<button class="btn btn-default" type="submit"
												ng-click="saveNelerOgrendinAnswer(nelerOgrendinQuestion.answerText, 1)">Save</button>
										</form>
									</c:if>
										<div ng-repeat="userAnswer in nelerOgrendinQuestion.foundAnswers track by userAnswer.userAnswerId" class="row" style="margin-bottom:15px;">
											<div class="col col-lg-8 answerText">
												{{userAnswer.userAnswerText}}
											</div>
											<div class="col col-lg-4" style="text-align:right;">
												<button type="button" class="btn btn-small" ng-click="toggleModal(userAnswer, $event)">+C</button>
												<button type="button" class="btn btn-small btn-danger glyphicon glyphicon-pencil" ng-click="editNelerOgrendinAnswer(exper, $index)"></button>
												<button type="button" class="btn btn-small btn-danger glyphicon glyphicon-trash" ng-click="deleteNelerOgrendinAnswer(userAnswer, $index);"></button>
											</div>
										</div>
									</div>
								</div>
								<div class="item panel panel-default" style="background: url('/resources/images/beandone_questions_background.png') no-repeat; moz-background-size: cover; -moz-background-size: cover; border:0px; padding-left:25px;">
									<div class="panel-heading" style="border:0px; background-color:initial !important;">Bug&uuml;n neler diliyorsun?
										<a href="#myCarousel" role="button" data-slide="next" style="float:right;margin-right:5px;">
											<span>&gt;&gt;</span>
										</a>
										<a href="#myCarousel" role="button" data-slide="prev" style="float:right;margin-right:5px;">
											<span>&lt;&lt;</span>
										</a>
									</div>
									<div class="panel-body">
									<c:if test="${usersCurrentDate.equals(selectedDate)}">
										<form>
											<textarea class="form-control" rows="2" cols="30"
												ng-model="whatIsYourWishQuestion.answerText"></textarea>
											<br />
											<button class="btn btn-default" type="submit"
												ng-click="saveWhatIsYourWishAnswer(whatIsYourWishQuestion.answerText, 2)">Save</button>
										</form>
									</c:if>
										<div ng-repeat="userAnswer in whatIsYourWishQuestion.foundAnswers track by userAnswer.userAnswerId" class="row" style="margin-bottom:15px;">
											<div class="col col-lg-8">
												{{userAnswer.userAnswerText}}
											</div>
											<div class="col col-lg-4" style="text-align:right;">
												<button type="button" class="btn btn-small btn-danger glyphicon glyphicon-trash" ng-click="deleteWhatIsYourWishAnswer(userAnswer, $index);"></button>
												<button type="button" class="btn btn-small" ng-click="toggleModal(userAnswer, $event)">+C</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//$('#test').BootSideMenu({ side: "left", autoClose: true });
	</script>
	<%@include file="footer.jsp"%>
</body>

</html>
