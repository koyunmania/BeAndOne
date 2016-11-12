<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@page import="org.springframework.security.core.context.SecurityContext"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<nav class="navbar navbar-fixed-top" role="navigation" style="background-color:#BBB;">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/">BeOne</a>
		</div>
		<div class="navbar-collapse collapse" id="navbar-collapsible">
			<ul class="nav navbar-nav navbar-right">
			<sec:authorize access="hasRole('AUTHENTICATED')">
				<li><a href="/profile">Profile</a></li>
				<li><a href="/logout">Logout</a></li>
			</sec:authorize>
			<sec:authorize access="not hasRole('AUTHENTICATED')">
				<li><a href="/login">Login</a></li>
				<li><a href="/register">Register</a></li>
			</sec:authorize>
			</ul>
			<sec:authorize access="hasRole('AUTHENTICATED')">
			<form class="navbar-form">
				<div class="form-group" style="display:inline;">
					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-search"></span></span>
						<input type="text" class="form-control">
					</div>
				</div>
			</form>
			</sec:authorize>
		</div>
		<!--/.navbar-collapse -->
	</div>
</nav>