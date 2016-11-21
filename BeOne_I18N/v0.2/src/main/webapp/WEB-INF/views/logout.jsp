<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<%@include file="header.jsp"%>
<body>
	<%@include file="menu.jsp"%>
	<div class="container mainarea">
		<h1>Hello world!</h1>

		<P>The time on the server is ${serverTime}.</P>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>
