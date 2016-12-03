<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@include file="header.jsp"%>
<style>
<!--
body {
	padding-top: 70px;
}
-->
</style>
<link href="/resources/css/landing-page.css" rel="stylesheet">

<body class="loginview">
	<%@include file="menu.jsp"%>
	<div class="container mainarea">
		<div class="row loginframeplaceholder">
			<div></div>
		</div>
		<div class="intro-header">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2 loginframe">
						<div class="intro-message">        
                    	</div>
						<c:if test="${verificationResultMessage != null}">
							<div class="row">
								<h2>Hesap Aktivasyon</h2>
							</div>
							<div class="row"
								style="display:${(!verificationResultIsSuccess) ? "block" : "none"};">
								<div class="alert alert-danger" role="alert">

									${verificationResultMessage}</div>
							</div>
							<div class="row"
								style="display:${(verificationResultIsSuccess) ? "block" : "none"};">
								<div class="alert alert-success" role="alert">
									${verificationResultMessage}</div>
							</div>
						</c:if>

						<c:if test="${creationResultMessage != null}">
							<div class="row"
								style="display:${(!creationResultIsSuccess && (creationResultMessage != null || validationErrors != null)) ? "block" : "none"};">
								<div class="alert alert-danger" role="alert">
									${creationResultMessage}
									<c:if test="${validationErrors != null}">
										<ul>
											<c:forEach var="error" items="${validationErrors}">
												<li>${error.fieldName}${error.validationMessage}</li>
											</c:forEach>
										</ul>
									</c:if>
								</div>
							</div>
							<div class="row"
								style="display:${(creationResultIsSuccess && creationResultMessage != null && validationErrors == null) ? "block" : "none"};">
								<div class="alert alert-success" role="alert">
									${creationResultMessage}</div>
							</div>
						</c:if>

						<c:if test="${loginResultMessage != null}">
							<div class="row"
								style="display:${(!loginResultIsSuccess && (loginResultMessage != null || validationErrors != null)) ? "block" : "none"};">
								<div class="alert alert-danger" role="alert">
									${loginResultMessage}
									<c:if test="${validationErrors != null}">
										<c:forEach var="error" items="${validationErrors}">
								${error.fieldName} ${error.validationMessage}
								</c:forEach>
									</c:if>
								</div>
							</div>
							<div class="row"
								style="display:${(loginResultIsSuccess && loginResultMessage != null && validationErrors == null) ? "block" : "none"};">
								<div class="alert alert-success" role="alert">
									${loginResultMessage}</div>
							</div>
						</c:if>

					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- -Login Modal -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content login-modal">
				<div class="modal-header login-modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title text-center" id="loginModalLabel">Giris Yap</h4>
				</div>
				<div class="modal-body">
					<div class="text-center">
						<form id="login-form" method="POST" action="/login" class="form-horizontal">
							<div class="form-group">
								<label for="email" class="col-sm-3 control-label">Email</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="email" name="email" placeholder="Email">
								</div>
							</div>
							<div class="form-group">
								<label for="password" class="col-sm-3 control-label">Password</label>
								<div class="col-sm-8">
									<input type="password" class="form-control" id="password" name="password" placeholder="Password">
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-6 col-md-offset-3">
									<button type="submit" id="login_btn" class="btn btn-block bt-login"
								data-loading-text="Signing In....">Giris Yap</button>
								</div>
							</div>
							
								
						</form>
						
						<div class="clearfix"></div>
						
						<div class="form-group">
							ya da
						</div>
						<div class="clearfix"></div>
						<form role="form" method="POST" action="/signin/facebook">
							<div class="col-sm-6 col-md-offset-3">
								<button class="btn btn-default btn-block facebook"><i class="fa fa-facebook modal-icons"></i> Facebook ile giris olun</button>
							</div>
						</form>
						<div class="clearfix"></div>
						<form role="form" method="POST" action="/signin/twitter">
							<div class="col-sm-6 col-md-offset-3">
								<button class="btn btn-default btn-block twitter"><i class="fa fa-twitter modal-icons"></i> Twitter ile giris olun</button>
							</div>
						</form>
						<div class="clearfix"></div>
							
						<!--
						<div class="clearfix"></div>
						<div class="login-modal-footer">
							<div class="row">
								<div class="col-xs-8 col-sm-8 col-md-8">
									<i class="fa fa-lock"></i> <a href="javascript:;"
										class="forgetpass-tab"> Forgot password? </a>
								</div>
								<div class="col-xs-4 col-sm-4 col-md-4">
									<i class="fa fa-check"></i> <a href="javascript:;"
										class="signup-tab"> Sign Up </a>
								</div>
							</div>
						</div>
						-->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- - Login Model Ends Here -->
	
	
	<!-- -Registration Modal -->
	<div class="modal fade" id="registrationModal" tabindex="-1" role="dialog" aria-labelledby="registrationModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content login-modal">
				<div class="modal-header login-modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title text-center" id="lregistrationModalLabel">Kayit Ol</h4>
				</div>
				<div class="modal-body">
					<div class="text-center">
						<div class="clearfix"></div>
						<form id="registration-form" method="POST" action="/register" class="form-horizontal">
							<div class="form-group">
								<label for="firstname" class="col-sm-3 control-label">Firstname</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="firstname" name="firstname" placeholder="Firstname">
								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-sm-3 control-label">Lastname</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="lastname" name="lastname" placeholder="Lastname">
								</div>
							</div>
							<div class="form-group">
								<label for="email" class="col-sm-3 control-label">Gender</label>
								<div class="col-sm-9">
									 <select class="form-control" name="gender">
									 <option value="Female">Female</option>
									 <option value="Male">Male</option>
									 </select>
								</div>
							</div>
							<div class="form-group">
								<label for="email" class="col-sm-3 control-label">Email</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="email" name="email" placeholder="Email">
								</div>
							</div>
							<div class="form-group">
								<label for="password" class="col-sm-3 control-label">Password</label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="password" name="password" placeholder="Password">
								</div>
							</div>
							<div class="form-group">
								<label for="passwordRepeat" class="col-sm-3 control-label">Repeat your password</label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="passwordRepeat" name="passwordRepeat" placeholder="Repeat your password">
								</div>
							</div>
							<div class="col-sm-6 col-md-offset-3">
								<button type="submit" id="register_btn"
									class="btn btn-block bt-login"
									data-loading-text="Registering....">Kaydol</button>
							</div>
						</form>
						
						<div class="clearfix"></div>
						
						<div class="form-group">
							ya da
						</div>
						<div class="clearfix"></div>
						<form role="form" method="POST" action="/connect/facebook">
							<div class="col-sm-6 col-md-offset-3">
								<button class="btn btn-default btn-block facebook"><i class="fa fa-facebook modal-icons"></i> Facebook ile kayit olun</button>
							</div>
						</form>
						<div class="clearfix"></div>
						<form role="form" method="POST" action="/connect/twitter">
							<div class="col-sm-6 col-md-offset-3">
								<button class="btn btn-default btn-block twitter"><i class="fa fa-twitter modal-icons"></i> Twitter ile kayit olun</button>
							</div>
						</form>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- - Registration Modal Ends Here -->

	<%@include file="footer.jsp"%>
</body>
</html>
