<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<%@include file="header.jsp"%>
<body>
	<%@include file="menu.jsp"%>
	<div class="container-fluid mainarea">
		<div class="col-lg-4 profileframe">
			<div class="well bs-component">
				<form class="form-horizontal">
					<fieldset>
						<legend>
							<h3>Selcuk Beyhan</h3>
						</legend>
						<div class="form-group">
							<label for="inputFirstname" class="col-lg-2 control-label">Firstname</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputFirstname"
									placeholder="Firstname">
							</div>
						</div>
						<div class="form-group">
							<label for="inputLastname" class="col-lg-2 control-label">Lastname</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputLastname"
									placeholder="Lastname">
							</div>
						</div>
						<div class="form-group">
							<label for="select" class="col-lg-2 control-label">Gender</label>
							<div class="col-lg-10">
								<select class="form-control" id="select">
									<option>Select an option</option>
									<option>Female</option>
									<option>Male</option>
									<option>Other</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="inputBirthday" class="col-lg-2 control-label">Birthday</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputBirthday" placeholder="Birthday">
							</div>
						</div>
						<div class="form-group">
							<label for="inputWeight" class="col-lg-2 control-label">Weight (kg)</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputWeight" placeholder="Weight">
							</div>
						</div>
						<div class="form-group">
							<label for="inputHeight" class="col-lg-2 control-label">Height (cm)</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputHeight" placeholder="Height">
							</div>
						</div>
						<div class="form-group">
							<label for="inputShoeSize" class="col-lg-2 control-label">Shoe
								Size</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputShoeSize"
									placeholder="Shoe Size">
							</div>
						</div>
						<div class="form-group">
							<label for="inputJerseySize" class="col-lg-2 control-label">Jersey Size</label>
							<div class="col-lg-10">
								<input type="text" class="form-control" id="inputJerseySize" placeholder="Jersey Size">
							</div>
						</div>
					</fieldset>
				</form>
			</div>
			
			<div class="row">
				<h4>Playing in Teams</h4>
				<ul>
					<li><a href="/team" class="btn btn-link">Team 1</a></li>
					<li><a href="/team" class="btn btn-link">Team 2</a></li>
					<li><a href="/team" class="btn btn-link">Team 3</a></li>
					<li><a href="/team" class="btn btn-link">Team 4</a></li>
					<li><a href="/team" class="btn btn-link"><span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;Add Team</a></li>
					<li><a href="/team" class="btn btn-link">Add here or from Team Profile?</a></li>
				</ul>
			</div>
		</div>
		<div class="col-lg-4 profileframe">
			<div class="row">
				<h4>Coming Matches</h4>
				<div class="matchContainer">
					<h5>
						<a href="#" class="btn btn-link">FC-Anadolu</a> vs. <a href="#" class="btn btn-link">MTV Schwabing</a>
					</h5>
					<div><label class="control-label">Date</label>2015-01-25 </div>
					<div><label class="control-label">Time</label>16:30 </div> 
                    <div><label class="control-label">Location</label>Map? Modal?Elisabeth-Kohn-Str. 4 80809 Muenchen </div>
				</div>
				<div class="matchContainer">
					<h5>
						<a href="#" class="btn btn-link">FC-Anadolu</a> vs. <a href="#" class="btn btn-link">MTV Schwabing</a>
					</h5>
					<div><label class="control-label">Date</label>2015-01-25 </div>
					<div><label class="control-label">Time</label>16:30 </div> 
                    <div><label class="control-label">Location</label>Map? Modal?Elisabeth-Kohn-Str. 4 80809 Muenchen </div>
				</div>
			</div>
			<div class="row">
				<h4>Past Matches</h4>
				<div class="matchContainer">
					<h5>
						<a href="#" class="btn btn-link">FC-Anadolu</a> vs. <a href="#" class="btn btn-link">MTV Schwabing</a>
					</h5>
					<div><label class="control-label">Date</label>2015-01-25 </div>
					<div><label class="control-label">Time</label>16:30 </div> 
                    <div><label class="control-label">Location</label>Map? Modal?Elisabeth-Kohn-Str. 4 80809 Muenchen </div>
				</div>
				<div class="matchContainer">
					<h5>
						<a href="#" class="btn btn-link">FC-Anadolu</a> vs. <a href="#" class="btn btn-link">MTV Schwabing</a>
					</h5>
					<div><label class="control-label">Date</label>2015-01-25 </div>
					<div><label class="control-label">Time</label>16:30 </div> 
                    <div><label class="control-label">Location</label>Map? Modal?Elisabeth-Kohn-Str. 4 80809 Muenchen </div>
				</div>
			</div>
		</div>
		<div class="col-lg-3 profileframe">
			<div class="row">
				<h4>Followed Teams</h4>
				<ul>
					<li><a href="/team" class="btn btn-link">Team 1</a></li>
					<li><a href="/team" class="btn btn-link">Team 2</a></li>
					<li><a href="/team" class="btn btn-link">Team 3</a></li>
					<li><a href="/team" class="btn btn-link">Team 4</a></li>
					<li><a href="/team" class="btn btn-link"><span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;Add Team</a></li>
					<li><a href="/team" class="btn btn-link">Add here or from Team Profile?</a></li>
				</ul>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>
