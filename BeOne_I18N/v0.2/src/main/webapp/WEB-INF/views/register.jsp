<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<%@include file="header.jsp"%>
<body>
	<%@include file="menu.jsp"%>
	<div class="container mainarea">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<div class="row">
					<h2 class="registerTitle" style="margin-top: 60px;">Enter your personal information</h2>
				</div>
				<div class="row" style="display:${(!creationResultIsSuccess && (creationResultMessage != null || validationErrors != null)) ? "block" : "none"};">
					<div class="alert alert-danger" role="alert">
					<c:if test="${creationResultMessage != null}">
					${creationResultMessage}
					</c:if>
					<c:if test="${validationErrors != null}">
						<ul>
						<c:forEach var="error" items="${validationErrors}">
							<li>${error.fieldName} ${error.validationMessage}</li>
						</c:forEach>
						</ul>
					</c:if>
					</div>
				</div>
				<div class="row" style="display:${(creationResultIsSuccess && creationResultMessage != null && validationErrors == null) ? "block" : "none"};">
					<div class="alert alert-success" role="alert">
						${creationResultMessage}
					</div>
				</div>
				<form role="form" method="POST" action="/register">
					<div class="row">
						<div class="form-group">
							<label for="email">Email</label> <input type="email"
								class="form-control" id="email" name="email" placeholder="Email">
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="username">Username</label> <input type="text"
								class="form-control" id="username" name="username" placeholder="Username">
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								class="form-control" id="password" name="password" placeholder="Password">
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="passwordRepeat">Repeat Password</label> <input
								type="password" class="form-control" name="passwordRepeat" id="passwordRepeat"
								placeholder="Repeat Password">
						</div>
					</div>
					<div class="row">
						<input type="submit" class="btn btn-default" value="Register"/>
					</div>
					<div style="height: 20px;"></div>
				</form>
<!-- 				<div class="row"> -->
<%-- 					<form role="form" method="POST" action="/signin/facebook" style="display:inline;"> --%>
<!-- 						<button type="submit" class="btn btn-default"> -->
<!-- 							<i class="fa fa-facebook"></i>Facebook -->
<!-- 						</button> -->
<!-- 					</form> -->
<%-- 					<form role="form" method="POST" action="/signin/twitter" style="display:inline;"> --%>
<!-- 						<button type="submit" class="btn btn-default"> -->
<!-- 							<i class="fa fa-twitter"></i>Twitter -->
<!-- 						</button> -->
<!-- 					</form> -->
<!-- 				</div> -->
				<div class="row">
					<form role="form" method="POST" action="/connect/facebook" style="display:inline;">
						<button type="submit" class="btn btn-default">
							<i class="fa fa-facebook"></i>&nbsp;Facebook
						</button>
					</form>
					<form role="form" method="POST" action="/connect/twitter" style="display:inline;">
						<button type="submit" class="btn btn-default">
							<i class="fa fa-twitter"></i>&nbsp;Twitter
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>
