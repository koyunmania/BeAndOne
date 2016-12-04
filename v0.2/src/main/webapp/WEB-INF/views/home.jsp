<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page session="false"%>
<%@include file="header.jsp"%>

<!--  angular social share includes -->
<link rel='stylesheet' href="/resources/js/facebookSDK/angular-socialshare.css">

<body onLoad="window.scroll(0, 350)">
	<div ng-app="beone" ng-controller="RootCtrl" ng-init="initRoot()" class="container-fluid">
		<div class="row">
			<div class="title-page col-md-12" style="background: url('http://d3sljlta800p6s.cloudfront.net/Cover/${coverPhoto.photoFileName}') no-repeat; !important; background-size:cover !important;">
				<div class="b-logo">
				</div>
				<!--  <div class="mood">
					<h3><spring:message code="label.home.cover.howisyourmood" /></h3>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Awesome" href=''>&#x1F603</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Good" href=''>&#x1F60A</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Neutral" href=''>&#x1F614</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Sad" href=''>&#x1F621</a>
					<a class="emoji" data-toggle="tooltip" data-placement="bottom" title="Crying" href=''>&#x1F62D</a>
				</div> -->
				<a href="https://www.instagram.com/benowmehere/" class="btn btn-default instagram beone-instagram" style="background-color:transparent;font-weight:bold;font-size:16px; border:0px;">
					<i class="fa fa-instagram"></i> @benowmehere
				</a>
			</div>
			<div class="col-md-2">
				<%@include file="leftmenu.jsp"%>
			</div>
			<div class="col-md-10">
				<div class="row info-bar" style="z-index:-20;position:absolute;"> 
					<div class="col-md-12">
						<div>
							<a style="color: white; text-decoration: none;" class="fa fa-cog dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
							</a>
							<ul class="dropdown-menu">
								<li><a href ng-click="openProfileModal();">Profile</a></li>
								<li><a href="/logout" onclick="window.location.href='/logout'">Logout</a></li>
							</ul>
							<span class="info-date">{{convertToReadabledDate(selectedDate)}} | <span id="time"></span> | {{profile.currentCity.cityName}} {{","+ selectedCountry.countryName}}</span>
						</div>
					</div>
				</div>
				<div class="row" style="margin-top:60px;">
					<div class="col-md-7" ng-controller="HappeningCtrl" ng-init="initHappenings()">
						<h2 id="happenings-header">Bugunkuler</h2>
						<div ng-repeat="doubleHappening in doubleHappenings" class="row">
							<div class="col-md-6">
								<div style="font-size:40px; margin-right: 0px; background-color: transparent; margin-right: 10px;">
										<div class="row" style="box-shadow: 2px 2px 5px #999999; background-color:{{doubleHappening[0].subCategory.calendar.colorCode}}; padding-top: 15px; padding-bottom: 10px; border-top-left-radius: 10px; border-top-right-radius: 10px; margin-top: 15px;">
											<div class="col-md-2">
												<span style="color: white; font-family: 'Glyphter';">{{doubleHappening[0].subCategory.calendarIcon}}</span>
											</div>
											<div class="col-md-10">
												<span style="color: white; font-size:20px; vertical-align:middle">
													<label>{{doubleHappening[0].eventName}} {{(doubleHappening[0].eventType != 'FullDayEvent' ? doubleHappening[0].eventTimeDisplayable : '')}}</label>
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
											<div class="col-md-12" style="text-align:left; background-color: white; padding-right: 7.5%; padding-left: 7.5%;">
												<button type="button" class="btn btn-default plusc-button" ng-click="toggleModal(doubleHappening[0])"><img style="display: inline; margin-top: 2px;"
														src="/resources/images/+C logo-01.png" height="14px"/></button>
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
												<span style="color: white; font-family: 'Glyphter';">{{doubleHappening[1].subCategory.calendarIcon}}</span>
											</div>
											<div class="col-md-10">
												<span style="color: white; font-size:20px; vertical-align:middle">
													<label>{{doubleHappening[1].eventName}} {{(doubleHappening[1].eventType != 'FullDayEvent' ? doubleHappening[1].eventTimeDisplayable : '')}}</label>
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
											<div class="col-md-12" style="text-align:left; background-color: white; padding-right: 7.5%; padding-left: 7.5%;">
												<button type="button" class="btn btn-default plusc-button" ng-click="toggleModal(doubleHappening[1])"><img style="display: inline; margin-top: 2px;"
														src="/resources/images/+C logo-01.png" height="14px"/></button>
												<a href="https://www.google.com/search?q={{doubleHappening[1].eventName}}"
														target="_blank" class="btn btn-default btn-google"><img style="display: inline; margin-top: 2px;"
														src="../../resources/images/google-icon.svg" height="14px" /></a> 
											</div>
										</div>
								</div>
							</div>
						</div>
						
						<div id="happeningModal" class="modal fade" role="dialog">
							<div class="modal-dialog" style="width: 440px;">
								<!-- Modal content-->
								<div class="modal-content">
									<div class="modal-header" style="background-color:{{happening.subCategory.calendar.colorCode}}; color:white; font-weight:bold;">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<div class="row">
											<div class="col-lg-2">
												<h3 class="modal-title happening"><span style="color: white; font-family: 'Glyphter'; font-size:45px;">{{happening.subCategory.calendarIcon}}</span></h3> 
											</div>
											<div class="col-lg-7">
												<h3 class="modal-title happening">{{happening.eventName}} {{(happening.eventType != 'FullDayEvent' ? happening.eventTimeDisplayable : '')}}</h3> 
											</div>
										</div>
									</div>
									<div class="modal-body happening happening-modal-body">
										<!-- <div style="height: 40px;"></div>
										{{happening.eventDescription}}-->
										<img class="img-responsive" src="{{happening.eventHappeningPhotoUrl}}" style="width:400px;"/>
									</div>
									<div class="modal-footer" style="text-align:left;">
										<a facebook-feed-share class="fa fa-facebook btn btn-primary btn-facebook plusc-share-buttons"
											data-url='http://www.beandone.com'
											data-shares='shares'
											data-source='{{happening.eventHappeningPhotoUrl}}'
											data-picture='{{happening.eventHappeningPhotoUrl}}'
											data-name={{happening.eventName}}
											data-caption='Be&One'
											style="font-size:25px;">{{shares}}
										</a>
										<a  id="twitterButton" 
											style="font-size:25px;"
											class="fa fa-twitter btn btn-primary btn-twitter plusc-share-buttons"
											data-lang="tr"
											data-count='horizontal' 
											data-url='http://www.beandone.com'
											data-via='{{happening.eventHappeningPhotoUrl}}' 
											data-size="medium" href='https://twitter.com/intent/tweet?text={{happening.eventDescription}} #BeAndOne'></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-5">
						<h2 id="experiences-header" style="margin-bottom: 25px;">Positif Gunluk</h2>
						<div class="panel panel-default diary-panel" ng-controller="ExperienceCtrl" ng-init="initExperience()" style="background: url('/resources/images/beandone_questions_background.png') no-repeat; moz-background-size: cover; -moz-background-size: cover; border:0px; padding-left:25px;">
							<div class="panel-heading" style="border:0px; background-color:initial !important;">Bug&uuml;n ne gibi g&uuml;zellikler yasadin?</div>
							<div class="panel-body">
							<c:if test="${usersCurrentDate.equals(selectedDate)}">
								<form>
									<div class="row">
										<div class="col-lg-12">
											<textarea class="form-control" rows="2" id="experienceTextArea" cols="30" ng-model="newExperienceText"></textarea>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-12" style="text-align:right; margin-top:10px; background:url('/resources/images/beandone_questions_bigpencil.png') no-repeat;background-position-x:15px;background-position-y:bottom;">
											<button class="btn btn-default diary-buttons" type="submit"
												ng-click="addExperience(newExperienceText, selectedDate)">Save</button>
										</div>
									</div>
								</form>
							</c:if>
								<div class="nano">
									<div style="height:100px;" class="nano-content">
										<div ng-repeat="exper in experiences track by exper.experienceId" style="margin-bottom:15px;">
											<div class="row answer-text-container" style="margin-bottom:15px; padding-bottom:10px; min-height:85px; overflow:hidden;">
												<div class="col col-lg-9 experienceText">
												{{exper.experienceDescription}}
												</div>
												<div class="col col-lg-3" style="text-align:right;padding-right:0px;">
													<div class="row">
														<div class="col-lg-12" style="padding-left:10px;">
															<button type="button" id="experienceEditButton{{$index}}" class="btn btn-small btn-info fa fa-pencil diary-buttons" ng-click="updateExperience(exper, selectedDate, $index)" style="width:35px;"></button>
															<button type="button" id="experienceDeleteButton{{$index}}" class="btn btn-small btn-danger fa fa-trash-o diary-buttons" ng-click="deleteExperience(exper, $index)" style="width:35px;"></button>
														</div>
													</div>
													<div class="row" style="margin-top:5px;">
														<div class="col-lg-12" style="padding-left:10px;">
															<button type="button" class="btn btn-default plusc-button" ng-click="toggleModal(exper)" style="width:75px;"><img style="display: inline; margin-top: 2px;"
															src="/resources/images/+C logo-01.png" height="14px"/></button>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-12">
													<hr width="75%" style="border-color:#BBB; border-width:2px;"/>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div id="experienceModal" class="modal fade" role="dialog">
								<div class="modal-dialog" style="width:300px">
									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title happening">Guzellikleri paylas</h4> 
										</div>
										<div class="modal-body happening happening-modal-body"
											style="min-height: 150px !important;">
											<div style="height: 40px;"></div>
											{{experience.experienceDescription}}
										</div>
										<div class="modal-footer">
											<a facebook-feed-share class="fa fa-facebook btn btn-primary btn-facebook plusc-share-buttons"
												data-url='http://www.beandone.com'
												data-shares='shares'
												data-name={{experience.experienceDescription}}
												data-caption='Be&One'
												style="font-size:25px;">
											</a>
											<a id="twitterButton" 
												style="font-size:25px;"
												class="fa fa-twitter btn btn-primary btn-twitter plusc-share-buttons"
												data-lang="tr"
												data-count='horizontal' 
												data-url='http://www.beandone.com'
												data-text='{{experience.experienceDescription}}'
												data-size="medium" href="https://twitter.com/intent/tweet?text={{experience.experienceDescription}}"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<h2 id="experiences-header">G&uuml;nl&uuml;k Sorular</h2>
						<div id="myCarousel" class="carousel slide" data-interval="false">
							<div ng-controller="QuestionAnswerCtrl" ng-init="initQuestionAnswer('${selectedDate}')" class="carousel-inner" role="listbox">
								<div class="item panel panel-default active diary-panel" style="background: url('/resources/images/beandone_questions_background.png') no-repeat; moz-background-size: cover; -moz-background-size: cover; border:0px; padding-left:25px;">
									<div class="panel-heading" style="border:0px; background-color:initial !important;">Bugun neler ogrendin?
										<a href="#myCarousel" role="button" data-slide="next" style="float:right;margin-right:5px;color:#999; font-size:28px;">
											<i class="fa fa-chevron-right" aria-hidden="true"></i>
										</a>
										<a href="#myCarousel" role="button" data-slide="prev" style="float:right;margin-right:5px;color:#999; font-size:28px;">
											<i class="fa fa-chevron-left" aria-hidden="true"></i>
										</a>
									</div>
									<div class="panel-body">
									<c:if test="${usersCurrentDate.equals(selectedDate)}">
										<form>
											<div class="row">
												<div class="col-lg-12">
													<textarea class="form-control" rows="2" cols="30"
														ng-model="nelerOgrendinQuestion.answerText"></textarea>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-12" style="text-align:right; margin-top:10px; background:url('/resources/images/beandone_questions_bigpencil.png') no-repeat;background-position-x:15px;background-position-y:bottom;">
													<button class="btn btn-default diary-buttons" type="submit"
												ng-click="saveNelerOgrendinAnswer(nelerOgrendinQuestion.answerText, 1)">Save</button>
												</div>
											</div>
										</form>
									</c:if>
										<div class="nano">
											<div style="height:100px;" class="nano-content row">
												<div ng-repeat="userAnswer in nelerOgrendinQuestion.foundAnswers track by userAnswer.userAnswerId" class="col-lg-12 answer-text-container">
													<div class="row" style="margin-bottom:15px; padding-bottom:10px; min-height:85px; overflow:hidden;">
														<div class="col col-lg-9 answerText">
															{{userAnswer.userAnswerText}}
														</div>								
														<div class="col col-lg-3" style="text-align:right;">
															<div class="row">
																<div class="col-lg-12" style="padding-left:10px;">
																	<button type="button" id="experienceEditButton{{$index}}" class="btn btn-small btn-info fa fa-pencil diary-buttons" ng-click="editNelerOgrendinAnswer(exper, $index)" style="width:35px;"></button>
																	<button type="button" id="experienceDeleteButton{{$index}}" class="btn btn-small btn-danger fa fa-trash-o diary-buttons" ng-click="deleteNelerOgrendinAnswer(userAnswer, $index);" style="width:35px;"></button>
																</div>
															</div>
															<div class="row" style="margin-top:5px;">
																<div class="col-lg-12" style="padding-left:10px;">
																	<button type="button" class="btn btn-default plusc-button" ng-click="toggleModal(userAnswer, $event)" style="width:75px;"><img style="display: inline; margin-top: 2px;"
																	src="/resources/images/+C logo-01.png" height="14px"/></button>
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-12">
															<hr width="75%" style="border-color:#BBB; border-width:2px;"/>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="item panel panel-default diary-panel" style="background: url('/resources/images/beandone_questions_background.png') no-repeat; moz-background-size: cover; -moz-background-size: cover; border:0px; padding-left:25px;">
									<div class="panel-heading" style="border:0px; background-color:initial !important;">Bug&uuml;n neler diliyorsun?
										<a href="#myCarousel" role="button" data-slide="next" style="float:right;margin-right:5px;color:#999; font-size:28px;">
											<i class="fa fa-chevron-right" aria-hidden="true"></i>
										</a>
										<a href="#myCarousel" role="button" data-slide="prev" style="float:right;margin-right:5px;color:#999; font-size:28px;">
											<i class="fa fa-chevron-left" aria-hidden="true"></i>
										</a>
									</div>
									<div class="panel-body">
									<c:if test="${usersCurrentDate.equals(selectedDate)}">
										<form>												
											<div class="row">
												<div class="col-lg-12">
													<textarea class="form-control" rows="2" cols="30"
														ng-model="whatIsYourWishQuestion.answerText"></textarea>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-12" style="text-align:right; margin-top:10px; background:url('/resources/images/beandone_questions_bigpencil.png') no-repeat;background-position-x:15px;background-position-y:bottom;">
													<button class="btn btn-default diary-buttons" type="submit"
												ng-click="saveWhatIsYourWishAnswer(whatIsYourWishQuestion.answerText, 2)">Save</button>
												</div>
											</div>
										</form>
									</c:if>
										<div class="nano">
											<div style="height:100px;" class="nano-content row">
												<div ng-repeat="userAnswer in whatIsYourWishQuestion.foundAnswers track by userAnswer.userAnswerId" class="col-lg-12 answer-text-container">
													<div class="row" style="margin-bottom:15px; padding-bottom:10px; min-height:85px;">
														<div class="col col-lg-9">
															{{userAnswer.userAnswerText}}
														</div>														
														<div class="col col-lg-3" style="text-align:right;">
															<div class="row">
																<div class="col-lg-12" style="padding-left:10px;">
																	<button type="button" id="experienceEditButton{{$index}}" class="btn btn-small btn-info fa fa-pencil diary-buttons" ng-click="editWhatIsYourWishAnswer(userAnswer, $index)" style="width:35px;"></button>
																	<button type="button" id="experienceDeleteButton{{$index}}" class="btn btn-small btn-danger fa fa-trash-o diary-buttons" ng-click="deleteWhatIsYourWishAnswer(userAnswer, $index);" style="width:35px;"></button>
																</div>
															</div>
															<div class="row" style="margin-top:5px;">
																<div class="col-lg-12" style="padding-left:10px;">
																	<button type="button" class="btn btn-default plusc-button" ng-click="toggleModal(userAnswer, $event)" style="width:75px;"><img style="display: inline; margin-top: 2px;"
																	src="/resources/images/+C logo-01.png" height="14px"/></button>
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-12">
															<hr width="75%" style="border-color:#BBB; border-width:2px;"/>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							
							<div id="answerModal" class="modal fade" role="dialog">
								<div class="modal-dialog" style="width:300px">
									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title happening">Guzellikleri paylas</h4> 
										</div>
										<div class="modal-body happening happening-modal-body"
											style="min-height: 150px !important;">
											<div style="height: 40px;"></div>
											{{userAnswer.userAnswerText}}
										</div>
										<div class="modal-footer">
											<a facebook-feed-share class="fa fa-facebook btn btn-primary btn-facebook plusc-share-buttons"
												data-url='http://www.beandone.com'
												data-shares='shares'
												data-name={{userAnswer.userAnswerText}}
												data-caption='Be&One'
												style="font-size:25px;">
											</a>
											<a id="twitterButton" 
												style="font-size:25px;"
												class="fa fa-twitter btn btn-primary btn-twitter plusc-share-buttons"
												data-lang="tr"
												data-count='horizontal' 
												data-url='http://www.beandone.com'
												data-text='{{userAnswer.userAnswerText}}'
												data-size="medium" href="https://twitter.com/intent/tweet?text={{experience.experienceDescription}}"></a>
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
		
	function checkTime(i) {
		return (i < 10) ? "0" + i : i;
	}

    function startTime() {
        var today = new Date(),
            h = checkTime(today.getHours()),
            m = checkTime(today.getMinutes());
        document.getElementById('time').innerHTML = h + ":" + m;
        t = setTimeout(function () {
            startTime()
        }, 500);
    }
    startTime();
	
	</script>
	<%@include file="footer.jsp"%>
	<script src="https://raw.githubusercontent.com/jamesflorentino/nanoScrollerJS/master/bin/javascripts/jquery.nanoscroller.min.js"></script>
	
	<script type="text/javascript">
	$(".nano").nanoScroller({ alwaysVisible: true });
	
	/*
	function parallax(){
		var scrolled = $(window).scrollTop();
		//$('.title-page').css('top', (scrolled * 0.2) + 'px');
		
		var velocity = 0.5;
		var pos = $(window).scrollTop(); 
    $('.title-page').each(function() { 
        var $element = $(this);
        // subtract some from the height b/c of the padding
        var height = $element.height()-18;
        $(this).css('background-position', '50% ' + Math.round((height - pos) * velocity) + 'px'); 
    }); 
	}
	
	$(window).scroll(function(e){
		parallax();
	});
	*/
	
	</script>
</body>

</html>
