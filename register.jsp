<%@ include file="master.jsp" %>

<div class="container">
	
	<div class="row" style="margin-top:60px;">
		<div class="span8" style="margin-left:15px;">
			<form id="registerForm" class="form-horizontal" method="post" action="do/doregister.jsp">
				<fieldset>
					<legend class="">Register Form</legend>
					
					<%
					
					String error = request.getParameter("err");
					if(error != null) {
					%>
					<div class="alert alert-error">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<%= error%>
					</div>
					<%
				}
				%>
				
				<%
				
				String status = request.getParameter("status");
				if(status != null) {
				%>
				<div class="alert alert-success">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<%= status%>
				</div>
				<%
			}
			%>
			
			<div class="control-group ">
				<label class="control-label">Username</label>
				<div class="controls">
					<input type="text" name="username"  placeholder="Username" value="" />
				</div>
			</div>
			
			<div class="control-group ">
				<label class="control-label">Password</label>
				<div class="controls">
					<input type="password" name="password" placeholder="Password" />
				</div>
			</div>
			
			<div class="control-group ">
				<label class="control-label">Confirm Password</label>
				<div class="controls">
					<input type="password" name="confirmPassword" placeholder="Confirm Password" />
				</div>
			</div>

			<div class="control-group ">
				<label class="control-label">Email</label>
				<div class="controls">
					<input type="text" name="email" placeholder="Email" value=""/>
				</div>
			</div>
			
			<div class="control-group ">
				<label class="control-label">Full Name</label>
				<div class="controls">
					<input type="text" name="fullname" placeholder="Full Name" value=""/>
				</div>
			</div>

			
			<div class="control-group">
				<label class="control-label"> Gender </label>
				<div class="controls form-text" style="margin-top: 2px">
					<input type="radio" value="1" name="gender" /> <label style="display:inline;">Male </label>&nbsp;
					<input type="radio" value="2" name="gender" /> <label style="display:inline;">Female </label>
				</div>
			</div>

			<div class="control-group ">
				<label class="control-label">Birth Date</label>
				<div class="controls">
					<input type="date" name="date"/>
				</div>
			</div>
			
			<div class="control-group ">
				<label class="control-label">Address</label>
				<div class="controls">
					<textarea name="address" cols="5" rows="5"></textarea>
				</div>
			</div>
			
			<div class="control-group ">
				<label class="control-label">Phone</label>
				<div class="controls">
					<input type="text" name="phone" placeholder="Phone, number only" value="" />
				</div>
			</div>

			<div class="control-group ">
				<label class="control-label">Mobile Phone</label>
				<div class="controls">
					<input type="text" name="mobilephone" placeholder="Mobile Phone, number only" value="" />
				</div>
			</div>
			
			<div class="control-group ">
				<label class="control-label"></label>
				<div class="controls">
					<input type="checkbox" name="newsletter" value="1"/><label style="display:inline;">Accept Daily Newsletter From Escape</label>
				</div>
			</div>
			
		</fieldset>
		
		<div class="form-actions">
			<input type="submit" class="btn btn-primary" value="Register" />
		</div>
	</form>
	
</div>
<div class="span4" style="margin-left:15px;">
	<img src="assets/img/uss.JPG" style="width:auto;height:auto;">
</div>
</div> 
<!-- /container -->

<%@ include file="footer.jsp" %>