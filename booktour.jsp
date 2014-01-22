<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
	<style>
		.modified {
			margin-top:5px;
		}
	</style>
	<div class="container">
		<div class="row" style="margin-top:60px;">
			<!-- Left content -> login -->
			<div class="span6">
				<%
					String curUserID = (String)session.getAttribute("userid");
					Integer tempUserID = 0;
					String query2 = "SELECT TOP 1 PaymentTourID FROM TrPaymentTour " + 
					" ORDER BY PaymentTourID DESC";
					ResultSet rs2 = st.executeQuery(query2);

					if(rs2.next()) {
						tempUserID = rs2.getInt("PaymentTourID") + 1;
					} else {
						tempUserID = 1;
					}
					// passed param
					Integer tourid = Integer.parseInt(request.getParameter("tourid"));
					Integer tourQuantity = Integer.parseInt(request.getParameter("ddlTourQuantity"));
				%>

				<% if(session.getAttribute("username") == null || session.getAttribute("username") == "") { %>
					<form id="formLoginTour" class="form-horizontal" action="do/dologin.jsp" method="post">
						<legend>Login Form</legend>
						<input type="hidden" name="tourid" value="<%=tourid%>" />
						<input type="hidden" name="ddlTourQuantity" value="<%=tourQuantity%>" />
						<div class="alert alert-info">
							Please login first before start buying tour. If you're not a member, please <a href="register.jsp">register</a>
						</div>
						
						<div class="control-group">
							<label class="control-label">Username</label>
							<div class="controls">
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" placeholder="Input Your Username" name="txtUsername" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Password</label>
							<div class="controls">
								<input type="password" class="validate[required] text-input" data-prompt-position="topRight:-70" placeholder="Input Your Password" name="txtPassword" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Sign in</button>
						</div>
					</form>
				<% } else { %>
					<form id="formLoginTour" class="form-horizontal tourdetail" style="display:none;" action="do/dobooktour.jsp" method="POST">
						<legend>Tour Detail</legend>
						<%
						for(Integer i = 0; i < tourQuantity; i++) { %>

						<h4>Passenger <%=(i+1)%></h4>
						<div class="control-group">
							<label class="control-label">Full Name</label>
							<div class="controls">
								<input class="validate[required] text-input" data-prompt-position="topRight:-70" type="text" name="fullname<%=i%>" placeholder="Full Name" value="" />
							</div>
						</div>

						<div class="control-group ">
							<label class="control-label">Birth Date</label>
							<div class="controls">
								<input type="text" class="dateinput validate[required] text-input" data-prompt-position="topRight:-70" name="birthdate<%=i%>" placeholder="yyyy/mm/dd" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label"> Gender </label>
							<div class="controls form-text" style="margin-top: 2px">
								<input type="radio" class="validate[required] radio" value="1" name="gender<%=i%>" /> <label style="display:inline;">Male </label>&nbsp;
								<input type="radio" class="validate[required] radio" value="2" name="gender<%=i%>" /> <label style="display:inline;">Female </label>
							</div>
						</div>

						<div class="control-group ">
							<label class="control-label">Identity Number</label>
							<div class="controls">
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" name="identitynumber<%=i%>" placeholder="Identity Number" value=""/>
							</div>
						</div>
						<hr>
					<% } %>

						<legend>Tour Booking Confirmation</legend>
						<input type="hidden" name="userheaderid" value="<%=tempUserID%>" />
						<input type="hidden" name="tourid" value="<%=tourid%>" />
						<input type="hidden" name="ddlTourQuantity" value="<%=tourQuantity%>" />
						<input type="hidden" name="tourprice" value="" />
						<div class="control-group">
							<label class="control-label">Username</label>
							<div class="controls">
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" disabled name="txtUsername" value="<%=session.getAttribute("username")%>" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Password</label>
							<div class="controls">
								<input type="password" class="validate[required] text-input" data-prompt-position="topRight:-70" placeholder="Input Your Password" name="txtPassword" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Buy Tour</button>
						</div>
					</form>
				<% } %>
			</div>
		
			<!-- Right content -> Description -->
			<div class="span6">
				<form class="form-horizontal">
					<legend>Tour Summary Order</legend>
					<%
					
					String query = "SELECT tourid, tourimage, cityfromid, daydetail, mcf.cityname AS CityFromName, mcd.cityname AS CityDestinationName, startdate, enddate, FORMAT(startdate,'Long Date') as convStartDate, FORMAT(enddate,'Long Date') as convEndDate, capacity, mt.description, price, isPromo FROM mstour AS mt, mscity as mcf, mscity as mcd WHERE mcf.cityid=mt.cityfromid And mcd.cityid=mt.citydestinationid AND mt.tourid = " + tourid;

					ResultSet rs = st.executeQuery(query);
					while(rs.next()) {
					String oldtourPrice = rs.getString("price");
					Integer tourprice = Integer.parseInt(oldtourPrice.replace(".",""));
					Integer total = 2 * tourprice;
					
					%>
						<input type="hidden" name="tempTourPrice" value="<%=tourprice%>" />

						<div class="control-group">
							<label class="control-label">Tour Scene Preview :</label>
							<div class="controls form-text modified">
								<span>
									<img src="<%=rs.getString("tourimage")%>" style="width:350px;height:175px;">
								</span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Price : </label>
							<div class="controls form-text modified">
								<span>Rp. <%=oldtourPrice%></span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Tour City : </label>
							<div class="controls form-text modified">
								<span>
								<%=rs.getString("CityFromName")%> &nbsp;-&nbsp;<%=rs.getString("CityDestinationName")%> 
								</span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Capacity Left :</label>
							<div class="controls form-text modified">
								<span><%=rs.getString("capacity")%></span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Total :</label>
							<div class="controls form-text modified">
								<span>Rp. <%=total%></span>
							</div>
						</div>
						
					<% } %>
				</form>
			</div>
		</div> <!-- /row -->
    </div> <!-- /container -->


<%@ include file="footer.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		/* Initialize datepicker component */
		$(".dateinput").on('mouseover',function(data){
			$(".dateinput").datepicker({format:'yyyy-mm-dd'});
		});
		$(".tourdetail").slideDown();
		var tourprice = $("[name='tempTourPrice']").val();
		$("[name='tourprice']").val(tourprice);
		
		/* bind form with validation engine */
		$("#formLoginTour").validationEngine();
	});
</script>