<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>

	<style>
		.modified {
			margin-top:5px;
		}
	</style>

	<div class="container">
		
		<div class="row" style="margin-top:60px;">
			
			<!-- Left content login -->
			<div class="span6">
				
				<% if(session.getAttribute("username") == null || session.getAttribute("username") == "") { %>
					<form class="form-horizontal">
						<legend>Login Form</legend>
						<div class="alert alert-info">
							Please login first before start buying ticket. If you're not a member, please <a href="register.jsp">register</a>
						</div>
						
						<div class="control-group">
							<label class="control-label">Username</label>
							<div class="controls">
								<input type="text" placeholder="Input Your Username" name="txtUsername" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Password</label>
							<div class="controls">
								<input type="text" placeholder="Input Your Password" name="txtPassword" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Sign in</button>
						</div>
					</form>
				<% } else { %>
					<form class="form-horizontal">
						<legend>Login Form</legend>
						
						<div class="control-group">
							<label class="control-label">Username</label>
							<div class="controls">
								<input type="text" disabled placeholder="Input Your Username" name="txtUsername" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Password</label>
							<div class="controls">
								<input type="text" placeholder="Input Your Password" name="txtPassword" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Sign in</button>
						</div>
					</form>
				<% } %>
			</div>
		
			<div class="span6">

				<form class="form-horizontal">
					<legend>Flight Summary Order</legend>
					<div class="control-group">
						<label class="control-label">Airlines :</label>
						<div class="controls form-text modified">
							<span>
								<img src="assets/img/airlinelogo/airasia.gif" style="width:170px;height:50px;">
							</span>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">Price :</label>
						<div class="controls form-text modified">
							<span>Rp. 250.000</span>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">Route :</label>
						<div class="controls form-text modified">
							<span>Jakarta - Singapore</span>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">Flight Date :</label>
						<div class="controls form-text modified">
							<span>2013-12-12</span>
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label">Flight Time :</label>
						<div class="controls form-text modified">
							<span>23:00 - 24:00</span>
						</div>
					</div>
				</form>
			
			</div>
		
		</div> <!-- /row -->
		
    </div> <!-- /container -->


<%@ include file="footer.jsp" %>

<script type="text/javascript">
	$(".dateinput").on('mouseover',function(data){
			$(".dateinput").datepicker({format:'yyyy-mm-dd'});
		});
</script>