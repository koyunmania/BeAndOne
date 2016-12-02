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
								style="display:${(!verificationResultIsSuccess && loginResultMessage != null) ? "block" : "none"};">
								<div class="alert alert-danger" role="alert">

									${verificationResultMessage}</div>
							</div>
							<div class="row"
								style="display:${(verificationResultIsSuccess && loginResultMessage != null) ? "block" : "none"};">
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
					<h4 class="modal-title text-center" id="loginModalLabel">Connect</h4>
				</div>
				<div class="modal-body">
					<div class="text-center">
						<div role="tabpanel" class="login-tab">
							<!-- Nav tabs -->
							<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a id="signin-taba"
									href="#home" aria-controls="home" role="tab" data-toggle="tab">Sign
										In</a></li>
								<li role="presentation"><a id="signup-taba" href="#profile"
									aria-controls="profile" role="tab" data-toggle="tab">Sign
										Up</a></li>
							</ul>

							<!-- Tab panes -->
							<div class="tab-content">
								<div role="tabpanel" class="tab-pane active text-center"
									id="home">
									&nbsp;&nbsp; <span id="login_fail" class="response_error"
										style="display: none;">Login failed, please try again.</span>
									<div class="clearfix"></div>
									<form id="login-form" method="POST" action="/login">
										<div class="form-group">
											<div>
												<div class="input-group">
													<div class="input-group-addon">
														<i class="fa fa-user"></i>
													</div>
													<input type="text" class="form-control" id="email" name="email"
														placeholder="Username">
												</div>
												<span class="help-block has-error" id="email-error"></span>
											</div>
											<div class="form-group">
												<div class="input-group">
													<div class="input-group-addon">
														<i class="fa fa-lock"></i>
													</div>
													<input type="password" class="form-control" id="password" name="password"
														placeholder="Password">
												</div>
												<span class="help-block has-error" id="password-error"></span>
											</div>
										</div>

										<button type="submit" id="login_btn"
											class="btn btn-block bt-login"
											data-loading-text="Signing In....">Login</button>
										<div class="modal-social-icons">
											<a href='#' class="btn btn-default facebook"> <i
												class="fa fa-facebook modal-icons"></i> Sign In with
												Facebook
											</a> <a href='#' class="btn btn-default google"> <i
												class="fa fa-google-plus modal-icons"></i> Sign In with
												Google
											</a>

										</div>
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
									</form>
								</div>
								<div role="tabpanel" class="tab-pane" id="profile">
									&nbsp;&nbsp; <span id="registration_fail"
										class="response_error" style="display: none;">Registration
										failed, please try again.</span>
									<div class="clearfix"></div>
									<form id="registration-form" method="POST" action="/register">
										<div class="form-group">
											<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-user"></i>
												</div>
												<input type="text" class="form-control" id="username"
													placeholder="Username">
											</div>
											<span class="help-block has-error" data-error='0'
												id="username-error"></span>
										</div>
										<div class="form-group">
											<div class="input-group">
												<div class="input-group-addon">
													<i class="fa fa-at"></i>
												</div>
												<input type="text" class="form-control" id="remail"
													placeholder="Email">
											</div>
											<span class="help-block has-error" data-error='0'
												id="remail-error"></span>
										</div>
										<button type="submit" id="register_btn"
											class="btn btn-block bt-login"
											data-loading-text="Registering....">Kaydol</button>
										<div class="clearfix"></div>
										<div class="login-modal-footer">
											<div class="row">
												<div class="col-xs-4 col-sm-4 col-md-4">
													<i class="fa fa-check"></i> <a href="javascript:;"
														class="signin-tab"> Sign In </a>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- - Login Model Ends Here -->

	<%@include file="footer.jsp"%>
</body>
</html>
