<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" import="com.beone.webapp.model.*"%>
<%@ page session="false" import="java.util.ArrayList"%>
<%@ include file="header.jsp"%>
<body>
    <div class="container">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
				    <div class="input-append date" data-date="${selectedDate}" style="float:left; display:inline-block; vertical-align:bottom;">
						<input class="datepicker datepicker-input btn btn-default" type="text" value="${selectedDate}">
					</div>
                </div>
				<div style="float:right; margin-top:10px; margin-bottom:10px; padding:4px; display:inline;" ng-controller="WishCtrl">
					<ul class="homepage-wishes">
						<li><button ng-click="toggleModal()" class="btn btn-default">Open modal</button></li>
						<li ng-repeat="wish in wishes track by wish.userWishId">{{wish.wishText}}</li>
					</ul>
					
					<div id="myModal" class="modal fade" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">What is your wish?</h4>
								</div>
								<div class="modal-body">
									<div class="alert" ng-class="wishAddAlertClass" role="alert">
									{{wishAddResultText}}
									</div>
									<div class="form-group">
										<label for=wish>Your wish</label>
										<input type="text" class="form-control" ng-model="wishToAdd" placeholder="Enter your wish">
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-success" ng-click="saveWish()">Save</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
				</div>
            </div>
        </nav>
        
		<form action="/upload-calendar" enctype="multipart/form-data" method="POST">
			<div class="row">
				<div class="col-md-3 col-md-offset-3">
					<h2>Select Country</h2>
					<select name="country" onchange="populateCities(this);">
						<option value="-1">Select</option>
					<c:if test="${countries != null}">
						<c:forEach var="ct" items="${countries}">
						<option value="${ct.countryId}">${ct.countryName}</option>
						</c:forEach>
					</c:if>
					</select>
				</div>
				
				<div class="col-md-3">
					<h2>Select City</h2>
					<select name="city" id="city">
						<option value="-1">Select a country first...</option>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<h2>Select file to upload</h2>
					<input type="file" name="uploadFile"/>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<input type="submit" value="Upload file"/>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<c:if test="${resultMessages != null}">
						<h3>Upload Result</h3>
						<c:forEach var="msg" items="${resultMessages}">
						${msg}<br/>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</form>
    </div>
    
    <script type="text/javascript">
    function populateCities(selectElement) {
    	console.log("Selected value: " + selectElement.value);
    	
    	var cities = new Array();
    	var city = new Array();
    	<%
		ArrayList<City> providedCities = (ArrayList<City>)request.getAttribute("cities");
    	for(City ct : providedCities) {
    		%>
    		city = new Array();
    		city.push(<%=ct.getCountry().getCountryId()%>);
    		city.push(<%=ct.getCityId()%>);
    		city.push("<%=ct.getCityName()%>");
    		cities.push(city);
    		<%
    	}
    	%>
    	
    	$("#city").empty();
		$("#city").append('<option value="-1">Select a city</option>');
    	for(var i=0; i<cities.length; i++) {
    		if(cities[i][0] == selectElement.value) {
    			$("#city").append('<option value="'+cities[i][1]+'">'+cities[i][2]+'</option>');
    		}
    	}
    }
    </script>
</body>
</html>