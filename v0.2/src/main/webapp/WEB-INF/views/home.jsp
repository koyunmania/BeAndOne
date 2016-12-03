<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page session="false"%>
<%@include file="header.jsp"%>

<!--  angular social share includes -->
<link rel='stylesheet'
	href="/resources/js/facebookSDK/angular-socialshare.css">

<body onLoad="window.scroll(0, 350)">
	<div ng-app="beone" ng-controller="RootCtrl" ng-init="initRoot()" class="container-fluid">
		<div class="row">
			<div class="title-page col-md-12" style="background: url('http://d3sljlta800p6s.cloudfront.net/Cover/${coverPhoto.photoFileName}') no-repeat; !important; background-size:cover; background-position:center center; overflow:hidden; position:relative;">
				<div class="b-logo">
					<span>B</span>
				</div>
				<!--  <div class="mood">
					<h3><spring:message code="label.home.cover.howisyourmood" /></h3>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Awesome" href=''>&#x1F603</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Good" href=''>&#x1F60A</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Neutral" href=''>&#x1F614</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Sad" href=''>&#x1F621</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Crying" href=''>&#x1F62D</a>
				</div> -->
				<a href="https://www.instagram.com/benowmehere/" class="btn btn-default" style="background-color:transparent;">
					<div class="instagram fa fa-instagram">
						@benowmehere
					</div>
				</a>
			</div>
			<div class="col-md-2">
				<%@include file="leftmenu.jsp"%>
			</div>
			<div class="col-md-10">
				<div class="row info-bar" style="z-index:-20">
				<div class="col-md-9">
					<div>
						<a style="color: white; text-decoration: none;" class="fa fa-cog dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
						</a>
						<ul class="dropdown-menu">
							<li><a href ng-click="openProfileModal();">Profile</a></li>
							<li><a href="/logout" onclick="window.location.href='/logout'">Logout</a></li>
						</ul>
						<span class="info-date">{{selectedDate}} | {{current_time}}</span>
						<span class="info-date">{{profile.currentCity.cityName}}, {{selectedCountry.countryName}}</span>
					</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-7" ng-controller="HappeningCtrl" ng-init="initHappenings()">
						<h2 id="happenings-header">Bugunkuler</h2>
						<div ng-repeat="doubleHappening in doubleHappenings" class="row">
							<div class="col-md-6">
								<div style="font-size:40px; margin-right: 0px; background-color: transparent; margin-right: 10px;">
										<div class="row" style="box-shadow: 2px 2px 5px #999999; background-color:{{doubleHappening[0].subCategory.calendar.colorCode}}; padding-top: 15px; padding-bottom: 10px; border-top-left-radius: 10px; border-top-right-radius: 10px; margin-top: 15px;">
											<div class="col-md-2">
												<span style="color: white; font-family: 'beone_icons';">{{doubleHappening[0].subCategory.calendarIcon}}</span>
											</div>
											<div class="col-md-10">
												<span style="color: white; font-size:20px; vertical-align:middle">
													<label>{{doubleHappening[0].eventName}}</label>
												</span><br/>
												<span style="color: white; font-size:12px; vertical-align:middle">
													<label>{{doubleHappening[0].subCategory.calendarSubCategory}}</label>
												</span>
											</div>
										</div>
										<div class="row" style="box-shadow: 2px 2px 5px #999999; background-color: white;">
											<img src="{{doubleHappening[0].eventHappeningPhotoUrl}}" style="width: 85%; display: block; margin: 5% auto 5% auto;">
										</div>
										<div class="row" style="box-shadow: 2px 2px 5px #999999;">
											<div class="col-md-12" style="text-align:right; background-color: white; padding-right: 7.5%; padding-left: 7.5%;">
												<button type="button" class="btn btn-success" ng-click="toggleModal(doubleHappening[0])">+C</button>
												<a href="https://www.google.com/search?q={{doubleHappening[0].eventName}}"
														target="_blank" class="btn btn-default btn-google"><img style="display: inline; margin-top: 2px;"
														src="../../resources/images/google-icon.svg" height="14px" /></a> 
											</div>
										</div>
								</div>
							</div>
							
							<div ng-if="doubleHappening[1]" class="col-md-6">
								<div style="font-size:40px; margin-right: 0px; background-color: transparent; margin-right: 10px;">
										<div class="row" style="box-shadow: 2px 2px 5px #999999; background-color:{{doubleHappening[1].subCategory.calendar.colorCode}}; padding-top: 15px; padding-bottom: 10px; border-top-left-radius: 10px; border-top-right-radius: 10px; margin-top: 15px;">
											<div class="col-md-2">
												<span style="color: white; font-family: 'beone_icons';">{{doubleHappening[0].subCategory.calendarIcon}}</span>
											</div>
											<div class="col-md-10">
												<span style="color: white; font-size:20px; vertical-align:middle">
													<label>{{doubleHappening[1].eventName}}</label>
												</span><br/>
												<span style="color: white; font-size:12px; vertical-align:middle">
													<label>{{doubleHappening[1].subCategory.calendarSubCategory}}</label>
												</span>
											</div>
										</div>
										<div class="row" style="box-shadow: 2px 2px 5px #999999; background-color: white;">
											<img src="{{doubleHappening[1].eventHappeningPhotoUrl}}" style="width: 85%; display: block; margin: 5% auto 5% auto;">
										</div>
										<div class="row" style="box-shadow: 2px 2px 5px #999999;">
											<div class="col-md-12" style="text-align:right; background-color: white; padding-right: 7.5%; padding-left: 7.5%;">
												<button type="button" class="btn btn-success" ng-click="toggleModal(doubleHappening[1])">+C</button>
												<a href="https://www.google.com/search?q={{doubleHappening[1].eventName}}"
														target="_blank" class="btn btn-default btn-google"><img style="display: inline; margin-top: 2px;"
														src="../../resources/images/google-icon.svg" height="14px" /></a> 
											</div>
										</div>
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
										<img class="img-responsive" src="{{happening.eventHappeningPhotoUrl}}"/>
									</div>
									<div class="modal-footer">
										<a facebook-feed-share class="fa fa-facebook btn btn-primary btn-facebook"
											data-url='http://www.beandone.com'
											data-shares='shares'
											data-source='{{happening.eventHappeningPhotoUrl}}'
											data-picture='{{happening.eventHappeningPhotoUrl}}'
											data-name={{happening.eventName}}
											data-caption='Be&One'>{{shares}}
										</a>
										<a id="twitterButton" 
											class="btn-twitter"
											twitter data-lang="en"
											data-count='horizontal' 
											data-url='http://beandone.com'
											data-via='{{happening.eventHappeningPhotoUrl}}' 
											data-size="medium"></a>
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
						<h2 id="experiences-header" style="margin-bottom: 25px;">Positif Gunluk</h2>
						<div class="panel panel-default" ng-controller="ExperienceCtrl" ng-init="initExperience()" style="background: url('/resources/images/beandone_questions_background.png') no-repeat; moz-background-size: cover; -moz-background-size: cover; border:0px; padding-left:25px;">
							<div class="panel-heading" style="border:0px; background-color:initial !important;">Bug&uuml;n ne gibi g&uuml;zellikler yasadin?</div>
							<div class="panel-body" style="margin-right: 150px;">
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
														<button type="button" id="experienceEditButton{{$index}}" class="btn btn-small btn-info glyphicon glyphicon-pencil" ng-click="updateExperience(exper, selectedDate, $index)"></button>
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
									<div class="panel-body" style="margin-right: 150px;">
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
									<div class="panel-body" style="margin-right: 150px;">
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
