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
<body class="loginview">
	<%@include file="menu.jsp"%>
	<div class="container mainarea">
		<div class="row loginframeplaceholder">
			<div></div>
		</div>
		<div class="row">
			<div class="col-md-8 col-md-offset-2 loginframe">
				<div class="row">
					<h2>Enter your credentials</h2>
				</div>
				<div class="row" style="display:${(!loginResultIsSuccess && (loginResultMessage != null || validationErrors != null)) ? "block" : "none"};">
					<div class="alert alert-danger" role="alert">
					<c:if test="${loginResultMessage != null}">
					${loginResultMessage}
					</c:if>
					<c:if test="${validationErrors != null}">
						<c:forEach var="error" items="${validationErrors}">
						${error.fieldName} ${error.validationMessage}
						</c:forEach>
					</c:if>
					</div>
				</div>
				<div class="row" style="display:${(loginResultIsSuccess && loginResultMessage != null && validationErrors == null) ? "block" : "none"};">
					<div class="alert alert-success" role="alert">
						${loginResultMessage}
					</div>
				</div>
				<form role="form" method="POST" action="/login">
					<div class="row">
						<div class="form-group">
							<label for="email">Email</label> <input type="text" type="email"
								class="form-control" id="email" name="email" placeholder="Email">
						</div>
					</div>
					<div class="row">
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								class="form-control" id="password" name="password" placeholder="Password">
						</div>
					</div>
					<div class="row">
						<input type="submit" class="btn btn-default" value="Login"/>
					</div>
					<div style="height: 20px;"></div>
				</form>
				<div class="row">
					<form role="form" method="POST" action="/signin/facebook" style="display:inline;">
						<button type="submit" class="btn btn-default">
							<i class="fa fa-facebook"></i>&nbsp;Facebook
						</button>
					</form>
					<form role="form" method="POST" action="/signin/twitter" style="display:inline;">
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
