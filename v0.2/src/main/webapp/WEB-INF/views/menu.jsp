<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@page import="org.springframework.security.core.context.SecurityContext"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<nav class="navbar navbar-fixed-top" role="navigation" style="background-color:white;">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
				data-target="#navbar-collapsible">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#" style="height:76px; margin-left:20px;"><img src="/resources/images/beandone-logo-06.png" alt="Be&One" style="height:100%;"/></a>
		</div>
		<div class="navbar-collapse collapse" id="navbar-collapsible">
			<ul class="nav navbar-nav navbar-right" style="margin-top:12px;">
			<sec:authorize access="hasRole('AUTHENTICATED')">
				<li><a href="/logout">Logout</a></li>
			</sec:authorize>
			<sec:authorize access="not hasRole('AUTHENTICATED')">
				<li id="landing-login-button-listitem"><a class="btn btn-launch" href="javascript:;" data-toggle="modal" data-target="#loginModal" id="landing-login-button">GIRIS YAP</a></li>
				<li id="landing-register-button-listitem"><a class="btn btn-launch" href="javascript:;" data-toggle="modal" data-target="#loginModal" id="landing-register-button">KAYDOL</a></li>
			</sec:authorize>
			</ul>
		</div>
		<!--/.navbar-collapse -->
	</div>
</nav>