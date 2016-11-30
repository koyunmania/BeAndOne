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
				<div class="row" style="display:${(!verificationResultIsSuccess && loginResultMessage != null) ? "block" : "none"};">
					<div class="alert alert-danger" role="alert">
					<c:if test="${verificationResultMessage != null}">
					${verificationResultMessage}
					</c:if>
					</div>
				</div>
				<div class="row" style="display:${(verificationResultIsSuccess && loginResultMessage != null) ? "block" : "none"};">
					<div class="alert alert-success" role="alert">
						${verificationResultMessage}
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>
