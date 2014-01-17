<%@ page import="java.util.Date"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*, java.util.Date" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Escape</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">

		<!-- Load CSS Files here -->
		<link href="assets/bootstrap/css/bootstrap.css" rel="stylesheet" media="screen">
		<link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
		<link href="assets/bootstrap/css/bootstrap-responsive.css" rel="stylesheet" media="screen">
		<link href="assets/bootstrap/css/docs.css" rel="stylesheet" media="screen">
		<link href="assets/bootstrap/css/datepicker.css" rel="stylesheet">

		<!-- Load CSS Validation Engine -->
		<link rel="stylesheet" href="assets/validation/css/validationEngine.jquery.css" type="text/css"/>
		<link rel="stylesheet" href="assets/validation/css/template.css" type="text/css"/>
		
		<!-- Load JS Jquery Validation Engine -->
		<script src="assets/validation/js/jquery-1.8.2.min.js" type="text/javascript"></script>
		<script src="assets/validation/js/languages/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script>
		<script src="assets/validation/js/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body data-spy="scroll" data-target=".bs-docs-sidebar" id="pageBody" class="animated fadeInDown">
	
    <!-- Navbar
    ================================================== -->
    <div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner" style="background-color:#248cc1;">
			<div class="container" style="background-color:#248cc1;">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".navbar-inverse-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<div class="nav-collapse collapse navbar-inverse-collapse">
					<ul class="nav">
						<li><a href="index.jsp">Home</a></li>
						<li><a href="hotpromo.jsp">Promo Event<font style="font-size:17px;" class="blink">!</font></a></li>
						<li><a href="tour.jsp">Tour</a></li>
						<li><a href="hotel.jsp">Hotel</a></li>
						<li><a href="flight.jsp">Flight</a></li>
						<!-- If user has login, display confirmation menu -->
						<% if(session.getAttribute("username") != null && session.getAttribute("username") != "") { %>
							<li>
								<a href="confirmation.jsp">Confirmation</a>
							</li>
						<%}%>
					</ul>
					<ul class="nav pull-right">
						<li>
							<a href="whatisescape.jsp">What is Escape ?</a>
						</li>
						<!-- If user is not logged in -->
						<% if(session.getAttribute("username") == null || session.getAttribute("username") == "") { %>
						<li>
							<a href="register.jsp">Register</a>
						</li>
						<li>
							<!-- If page buyticket.jsp, bookhotel.jsp, booktour.jsp was opened, then hide login menu -->
							<!-- because the login form has been dispaled on related page, positioned on left of content -->
							<%
								String url = request.getRequestURI().replace("/escape/","");
								if(url.compareTo("buyticket.jsp") != 0 && url.compareTo("bookhotel.jsp") != 0 && url.compareTo("booktour.jsp") != 0) {
							%>
							<a id="btnOpenModalLogin" data-toggle="modal" data-target="#mdlLogin" style="cursor:pointer;">Login </a>
							<% } %>
						</li>
						<% } else { %>
						<li>
							<!-- If user has login, then display welcome message (with user name) to the user -->
							<a>Welcome, <%= session.getAttribute("username") %></a>
						</li>
						<li>
							<a href="do/dologout.jsp">Logout</a>
						</li>
						<% }%>
					</ul>
				</div><!-- /.nav-collapse -->
			</div>
		</div><!-- /navbar-inner -->
    </div>
	
	<!-- Logo goes here -->
	<header class="jumbotron subhead" id="overview">
		<div class="container">
			<img src="./assets/img/logo/logoescape.png" style="margin-left:-60px;margin-top:-30px;" />
			<!-- Contact div, display information about our company (contact, email, bbm, twitter) -->
			<div id="divContact" class="span3" style="border:1px solid #FFF;padding:10px; position:absolute; top:-15px; right:0;">
				<img src="assets/img/icon/icon-telephone.png" width="20"></img> 
				123456789<br>
				<img src="assets/img/icon/icon-email.png" width="20"></img>
				customer@escape.com<br>
				<img src="assets/img/icon/icon-bbm.png" width="20"></img>
				283EA8FD<br>
				<img src="assets/img/icon/icon-twitter.png" width="20"></img>
				@escapetour
			</div>
		</div>
	</header>
	
	<!-- Modal login -->
	<div id="mdlLogin" class="modal hide fade" tabindex="-1" role="dialog">
        <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">X</button>
			<h3 id="myModalLabel">Customer Login</h3>
		</div>
		<div class="modal-body">
		  	<form id="formLogin" class="form-horizontal" style="height:200px;" action="do/dologin.jsp" method="post">
			  	<div class="control-group">
					<label class="control-label">Username</label>
					<div class="controls">
						<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" placeholder="Input Your Username" name="txtUsername" id="txtUsername" />
					</div>
			 	</div>
			  	<div class="control-group">
					<label class="control-label">Password</label>
					<div class="controls">
						<input type="password" class="validate[required] text-input" data-prompt-position="topRight:-70" placeholder="Input Your password" id="txtPassword" name="txtPassword"/>
					</div>
			 	</div>
				<label id="error"></label>
		</div>
			<div class="modal-footer" style="margin-top:-20px;">	
				<button class="btn btn-primary" id="btnLogin" type="button">Login</button>
				<button class="btn" data-dismiss="modal" aria-hidden="cancel">Cancel</button>
			</div>
        </form>
	</div>
	
	<!-- If error is not null, then alert -->
	<%
		String err = request.getParameter("err");
		if(err != null)
			out.print("<script type='text/javascript'>alert('"+err+"');</script>");
	%>

	<!-- Load bootstrap JS here -->
	<!--<script type="text/javascript" src="assets/js/jquery.js"></script>-->
    <script src="assets/js/bootstrap-transition.js"></script>
    <script src="assets/js/bootstrap-alert.js"></script>
    <script src="assets/js/bootstrap-modal.js"></script>
    <script src="assets/js/bootstrap-dropdown.js"></script>
    <script src="assets/js/bootstrap-scrollspy.js"></script>
    <script src="assets/js/bootstrap-tab.js"></script>
    <script src="assets/js/bootstrap-tooltip.js"></script>
    <script src="assets/js/bootstrap-popover.js"></script>
    <script src="assets/js/bootstrap-button.js"></script>
    <script src="assets/js/bootstrap-collapse.js"></script>
    <script src="assets/js/bootstrap-carousel.js"></script>
    <script src="assets/js/bootstrap-typeahead.js"></script>
    <script src="assets/js/bootstrap-affix.js"></script>
	<script src="assets/js/bootstrap-datepicker.js"></script>
    <script src="assets/js/holder/holder.js"></script>
    <script src="assets/js/google-code-prettify/prettify.js"></script>
    <script src="assets/js/application.js"></script>
   

    <script type="text/javascript">
		$(document).ready(function(){
			$("#formLogin").validationEngine();
		});
	
		$("body").on("click", "#btnLogin", function()
		{
			var username = $("#txtUsername").val();
			var password = $("#txtPassword").val();

			if(username == "") 
			{ 
			 	$("#error").text("Username must be filled");
			} 
			
			else if(password == "") 
			{
				$("#error").text("Password must be filled");
			}
			
			else
			{
				window.location.href = "do/dologin.jsp?txtUsername=" + username + "&txtPassword=" + password;
			}
		});
    </script>
   
