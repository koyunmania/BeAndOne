<div class="user" ng-controller="ProfileCtrl" ng-init="initProfile()" style="margin-top:60px;">
	<ul class="nav nav-pills">
		<li role="presentation" class="dropdown" style="width:100%;">
			<a class="dropdown-toggle profile-area" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="padding:0px;text-align:center;">
				<img src="/profile/photo" class="img-thumbnail img-circle" onerror="this.src='/resources/images/defaultprofile.svg'" style="width:130px; height:130px;">
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
					<form class="form-horizontal">
						<div class="profile-item profile-area form-group">
							<img src="/profile/photo" class="img-thumbnail img-circle" style="width:130px; height:130px;" onerror="this.src='/resources/images/defaultprofile.png'"/>
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
						
						<div class="form-group">
							<label for="firstname" class="col-sm-5 control-label">Firstname</label>
							<div class="col-sm-7 profile-field-item">
								<span class="profileLabel">{{profile.firstname}}</span>
								<input type="text" class="form-control profileInput hidden" id="firstname" name="firstname" placeholder="Firstname" ng-model="profile.firstname">
							</div>
						</div>
						<div class="form-group">
							<label for="lastname" class="col-sm-5 control-label">Lastname</label>
							<div class="col-sm-7 profile-field-item">
								<span class="profileLabel">{{profile.lastname}}</span>
								<input type="text" class="form-control profileInput hidden" id="lastname" name="lastname" placeholder="Lastname" ng-model="profile.lastname">
							</div>
						</div>
						<div class="form-group">
							<label for="gender" class="col-sm-5 control-label">Gender</label>
							<div class="col-sm-7 profile-field-item">
								<span class="profileLabel">{{profile.gender}}</span>
								<select class="form-control profileInput hidden" name="gender" ng-model="profile.gender">
									<option value="-1">Select your gender</option>
									<option value="Female" ng-selected="{{profile.gender === 'Female'}}">Female</option>
									<option value="Male" ng-selected="{{profile.gender === 'Male'}}">Male</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="country" class="col-sm-5 control-label">Current Country</label>
							<div class="col-sm-7 profile-field-item">
								<span class="profileLabel">{{selectedCountry.countryName}}</span>
								<select class="form-control profileInput hidden" name="country" ng-model="selectedCountry" ng-change="selectCountry(selectedCountry)"
									ng-options="country.countryName for country in allCountries track by country.countryId">
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="city" class="col-sm-5 control-label">Current Citry</label>
							<div class="col-sm-7 profile-field-item">
								<span class="profileLabel">{{profile.currentCity.cityName}}</span>
								<select class="form-control profileInput hidden" name="city"
									ng-model="profile.currentCity"
									ng-options="city.cityName for city in selectedCountry.cities track by city.cityId">
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="birthday-year" class="col-sm-5 control-label">Birthday</label>
							<div class="col-sm-7 profile-field-item">
								<div class="row">
									<div class="col-lg-12">
										<span class="profileLabel">{{profile.birthday}}</span>
									</div>
								</div>
								<div class="row profileInput hidden">
									<div class="col-lg-12">
										<div class="row">
											<div class="col-lg-4">Year:</div>
											<div class="col-lg-8">
												<select class="form-control" name="birthday-year"
													ng-model="birthday.year"
													ng-options="y for y in years track by y">
												</select>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4">Month:</div>
											<div class="col-lg-8">
												<select class="form-control" name="birthday-month"
													ng-model="birthday.month"
													ng-options="m for m in months track by m">
												</select>
											</div>
										</div>
										<div class="row">
											<div class="col-lg-4">Day:</div>
											<div class="col-lg-8">
												<select class="form-control" name="birthday-day"
													ng-model="birthday.day"
													ng-options="d for d in days track by d">
												</select>
											</div>
										</div>
									</div>
								</div>
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
				ng-class="calendar.buttonClass"><span style="font-family:beone-font,'Glyphicons Halflings';float:left;"></span><!--<span class="{{calendar.calendarIcon}}" style="font-family:beone-font,'Glyphicons Halflings';float:left;"></span>-->&nbsp;{{calendar.calendarName}}</button>
			<div id="subCategoryModal{{$index}}" class="modal fade" role="dialog">
				<div class="modal-dialog" style="width: 400px;">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header" style="color:white; background-color:{{selectedCalendar.colorCode}}">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title happening">{{selectedCalendar.calendarName}} Subscription</h4>
						</div>
						<div class="modal-body">
							<button class="btn btn-default" ng-click="selectAllSubCategories(selectedCalendar.subCategories)">Select All</button>
							<span>Filter: </span><input ng-model="query" type="text"/>
							<form>
								<div class="subcategoryList">
									<div ng-repeat="subCategory in selectedCalendar.subCategories | filter:query | orderBy:subCategory.calendarSubCategory">
										<input id="subCategoryCheckbox{{subCategory.subcategoryId}}" type="checkbox" ng-click="addToSelectedSubCategoryList(subCategory, $index)" ng-model="checkboxValues[$index]" ng-checked="isUserSubCategory(subCategory) || selectAll">
										<label  class="checkbox-inline" style="color:{{selectedCalendar.colorCode}}; font-weight:bold;">
										<span style="font-family: 'Glyphter';">{{subCategory.calendarIcon}}</span>
											{{subCategory.calendarSubCategory}}
										</label>
									</div>
								</div>
								<div class="modal-footer">
									<button id="profileButton" class="btn btn-default" ng-click="addUserCalendarSubCategories(parentIndex, calendar.calendarId)">Subscribe</button>
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
