<div class="user" ng-controller="ProfileCtrl" ng-init="initProfile()">
	<ul class="nav nav-pills">
		<li role="presentation" class="dropdown" style="width:100%;">
			<div class="info-bar fa fa-cog">
				<span class="info-date">{{selectedDate}} | 13:48</span>
				<span class="info-date">{{profile.currentCity.cityName}}, {{selectedCountry.countryName}}</span>
			</div>
			<a class="dropdown-toggle profile-area" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
				<img src="/profile/photo" class="img-thumbnail img-circle" onerror="this.src='/resources/images/defaultprofile.svg'">
				<!--  <div class="img-thumbnail img-circle fa fa-user profile-picture"></div> -->
			</a>
			<ul class="dropdown-menu">
				<li><a href ng-click="openProfileModal();">Profile</a></li>
				<li><a href="/logout" onclick="window.location.href='/logout'">Logout</a></li>
			</ul>
		</li>
	</ul>
	
	<div id="profileModal" class="modal fade" role="dialog">
		<div class="modal-dialog" style="width: 400px;">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title happening">User Profile</h4>
				</div>
				<div class="modal-body" style="text-align: center;">
					<form>
						<div class="profile-item profile-area">
							<img src="/resources/images/defaultprofile.png" class="img-thumbnail profile-img" onerror="this.src='/resources/images/defaultprofile.png'"/>
							<div class="profileInput hidden">
								<div class="form-group">
									<label for="fileUpload">Select a file to upload</label>
									<input type="file" class="form-control" accept="image/*" id="fileUpload" name="files" data-url="/api/v1/profile/image" class="file">
								</div>
								<div>
									<div id="progress">
										<div class="bar" style="width: 0%;"></div>
									</div>
								</div>
								<div>
									<div class="alert alert-success" id="photoUploadSuccess" role="alert" style="display:none;">
										The photo has been uploaded successfully.
									</div>
									<div class="alert alert-danger" id="photoUploadFailure" role="alert" style="display:none;">
										There was an error in the upload. Please try again later.
									</div>
								</div>
								<button type="button" class="btn btn-primary" id="photoUploadButton">Upload</button>
							</div>
						</div>
						<div class="profile-item">
							<div class="row">
								<div class="col-md-6" style="text-align:right;"><label>Firstname:&nbsp;</label></div>
								<div class="col-md-6" style="text-align:left;"><span class="profileLabel">{{profile.firstname}}</span> <input
								type="text" class="profileInput hidden"
								ng-model="profile.firstname" value="{{profile.firstname}}"></div>
							</div>
						</div>
						<div class="profile-item">
							<div class="row">
								<div class="col-md-6" style="text-align:right;"><label>Lastname:&nbsp;</label></div>
								<div class="col-md-6" style="text-align:left;"><span class="profileLabel">{{profile.lastname}}</span> <input
								type="text" class="profileInput hidden"
								ng-model="profile.lastname" value="{{profile.lastname}}"></div>
							</div>
						</div>
						<div class="profile-item">
							<div class="row">
								<div class="col-md-6" style="text-align:right;"><label>Current Country:&nbsp;</label></div>
								<div class="col-md-6" style="text-align:left;"><span class="profileLabel">{{selectedCountry.countryName}}</span> <select class="profileInput hidden"
									ng-model="selectedCountry"
									ng-change="selectCountry(selectedCountry)"
									ng-options="country.countryName for country in allCountries track by country.countryId">
								</select></div>
							</div>
						</div>
						<div class="profile-item">
							<div class="row">
								<div class="col-md-6" style="text-align:right;"><label>Current City:&nbsp;</label></div>
								<div class="col-md-6" style="text-align:left;"><span class="profileLabel">{{profile.currentCity.cityName}}</span> <select class="profileInput hidden" 
									ng-model="profile.currentCity"
									ng-options="city.cityName for city in selectedCountry.cities track by city.cityId">
								</select></div>
							</div>
						</div>
						<div class="profile-item">
							<div class="row">
								<div class="col-md-6" style="text-align:right;"><label id="profileLabel">Gender:&nbsp;</label></div>
								<div class="col-md-6" style="text-align:left;"><span class="profileLabel">{{profile.gender}}</span> <select class="profileInput hidden" ng-model="profile.gender" size="{{profile.gender.length}}">
								<option ng-selected="{{profile.gender === 'Male'}}" value="Male">Male</option>
								<option ng-selected="{{profile.gender === 'Female'}}" value="Female">Female</option>
								</select></div>
							</div>
						</div>
						<div class="profile-item">
							<div class="row">
								<div class="col-md-6" style="text-align:right;"><label id="profileLabel">Birthday:&nbsp;</label></div>
								<div class="col-md-6" style="text-align:left;"><span class="profileLabel">{{profile.birthday}}</span> <div class="profileInput hidden" data-date="{{profile.birthday}}" style="display:inline-block" size="{{profile.birthday.length}}">
									<input class="datepicker datepicker-input birthday" style="display:inline-block; font-size: 14px; width: 90px; background-color: #ddd;" ng-model="profile.birthday" type="text" value="{{profile.birthday}}">
								</div></div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" id="profileButton" class="btn btn-default" ng-click="editProfile()">Edit</button>
							<button type="button" class="btn btn-default" ng-click="profileEditToSave()" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

				<!--  ng-class="calendar.buttonClass">{{calendar.calendarName}}</button> -->
	<div class="list-group">
		<div class="profile-label">{{greeting}} {{profile.firstname}}</div>
		<div ng-repeat="(parentIndex, calendar) in allCalendars">
			<button type="button" class="btn btn-lg btn-block btn-calendar" 
				ng-click="openSubCategoryModal(calendar, $index)" 
				ng-class="{true: calendar.buttonClass, false: 'btn-default'}[isCalendarAUserCalendar(calendar.calendarId)]"><span style="font-family:beone-font,'Glyphicons Halflings';float:left;"></span><!--<span class="{{calendar.calendarIcon}}" style="font-family:beone-font,'Glyphicons Halflings';float:left;"></span>-->&nbsp;{{calendar.calendarName}}</button>
			<div id="subCategoryModal{{$index}}" class="modal fade" role="dialog">
				<div class="modal-dialog" style="width: 400px;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title happening">{{calendar.calendarName}} Subscription</h4>
						</div>
						<div class="modal-body">
							<button class="btn btn-default" ng-click="selectAllSubCategories(selectedCalendar.subCategories)">Select All</button>
							<span>Filter: </span><input ng-model="query" type="text"/>
							<form>
								<div class="subcategoryList">
									<div ng-repeat="subCategory in selectedCalendar.subCategories | filter:query | orderBy:subCategory.calendarSubCategory">
										<input id="subCategoryCheckbox{{subCategory.subcategoryId}}" type="checkbox" ng-click="addToSelectedSubCategoryList(subCategory, $index)" ng-model="checkboxValues[$index]" ng-checked="isUserSubCategory(subCategory) || selectAll">
										<label  class="checkbox-inline">
											{{subCategory.calendarSubCategory}}
										</label>
									</div>
								</div>
								<div class="modal-footer">
									<button id="profileButton" class="btn btn-default" ng-click="addUserCalendarSubCategories(parentIndex, calendar.calendarId)">Subscribe</button>
									<button class="btn btn-default" data-dismiss="modal">Cancel</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="calendarContainer"><div></div></div>
