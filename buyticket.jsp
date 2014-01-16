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

				<%
					String curUserID = (String)session.getAttribute("userid");
					Integer tempUserID = 0;
					String query2 = "SELECT TOP 1 PaymentFlightID FROM TrPaymentFlight " + 
					" ORDER BY PaymentFlightID DESC";
					ResultSet rs2 = st.executeQuery(query2);

					if(rs2.next()) {
						tempUserID = rs2.getInt("PaymentFlightID") + 1;
					} else {
						tempUserID = 1;
					}
					// passed param
					String flightId = request.getParameter("flightId");
					Integer ticketquantity = Integer.parseInt(request.getParameter("ddlTicketQuantity"));
				%>

				<% if(session.getAttribute("username") == null || session.getAttribute("username") == "") { %>
					<form class="form-horizontal" action="do/dologin.jsp" method="post">
						<legend>Login Form</legend>
						<input type="hidden" name="flightId" value="<%=flightId%>" />
						<input type="hidden" name="ddlTicketQuantity" value="<%=ticketquantity%>" />
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

					<form class="form-horizontal flightdetail" style="display:none;" action="do/dobuyticket.jsp" method="POST">
					<legend>Flight Detail</legend>
					<%
						for(Integer i = 0; i < ticketquantity; i++) { %>

						<h4>Passenger <%=(i+1)%></h4>
						<div class="control-group">
							<label class="control-label">Full Name</label>
							<div class="controls">
								<input type="text" name="fullname<%=i%>" placeholder="Full Name" value="" />
							</div>
						</div>

						<div class="control-group ">
							<label class="control-label">Birth Date</label>
							<div class="controls">
								<input type="text" class="dateinput" name="birthdate<%=i%>" placeholder="yyyy/mm/dd" />
							</div>
						</div>

						<div class="control-group">
							<label class="control-label"> Gender </label>
							<div class="controls form-text" style="margin-top: 2px">
								<input type="radio" value="1" name="gender<%=i%>" /> <label style="display:inline;">Male </label>&nbsp;
								<input type="radio" value="2" name="gender<%=i%>" /> <label style="display:inline;">Female </label>
							</div>
						</div>

						<div class="control-group ">
							<label class="control-label">Identity Number</label>
							<div class="controls">
								<input type="text" name="identitynumber<%=i%>" placeholder="Identity Number" value=""/>
							</div>
						</div>
						<hr>
					<% } %>

					
						<legend>Flight Booking Confirmation</legend>
						<input type="hidden" name="userheaderid" value="<%=tempUserID%>" />
						<input type="hidden" name="flightId" value="<%=flightId%>" />
						<input type="hidden" name="ddlTicketQuantity" value="<%=ticketquantity%>" />
						<input type="hidden" name="ticketprice" value="" />
						<div class="control-group">
							<label class="control-label">Username</label>
							<div class="controls">
								<input type="text" disabled name="txtUsername" value="<%=session.getAttribute("username")%>" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Password</label>
							<div class="controls">
								<input type="text" placeholder="Input Your Password" name="txtPassword" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Buy Ticket</button>
						</div>
					</form>

					

				<% } %>
			</div>
		
			<div class="span6">

				<form class="form-horizontal">
					<legend>Flight Summary Order</legend>
					<%
					
					String query = "SELECT ma.airlineid, ma.airlinename,  airlineimage, flightid, cityfromid, mcf.cityname AS CityFrom, citydestinationid, mcd.cityname AS CityDestination, date, FORMAT(date,'Long Date') as convDate, time, ticketprice, capacity, ispromo FROM msflight mf, msairline ma, mscity mcf, mscity mcd where mf.airlineid=ma.airlineid AND mcf.cityid=mf.cityfromid AND mcd.cityid=mf.citydestinationid AND flightid = " + flightId;

					String cityfrom = request.getParameter("ddlCityFrom");
					String citydest = request.getParameter("ddlCityDestination");
					String dateflight = request.getParameter("dateFlight");
					
					ResultSet rs = st.executeQuery(query);
					while(rs.next()) {
					String oldticketPrice = rs.getString("ticketprice");
					Integer ticketPrice = Integer.parseInt(oldticketPrice.replace(".",""));
					Integer total = ticketquantity * ticketPrice;
					
					%>
						<input type="hidden" name="tempTicketPrice" value="<%=ticketPrice%>" />

						<div class="control-group">
							<label class="control-label">Airlines :</label>
							<div class="controls form-text modified">
								<span>
									<img src="<%=rs.getString("airlineimage")%>" style="width:170px;height:50px;">
								</span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Price :</label>
							<div class="controls form-text modified">
								<span>Rp. <%=oldticketPrice%></span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Route :</label>
							<div class="controls form-text modified">
								<span><%=rs.getString("CityFrom")%> - <%=rs.getString("CityDestination")%></span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Flight Date :</label>
							<div class="controls form-text modified">
								<span><%=rs.getString("convDate")%></span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Flight Time :</label>
							<div class="controls form-text modified">
								<span><%=rs.getString("time")%></span>
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

		$(".dateinput").on('mouseover',function(data){
			$(".dateinput").datepicker({format:'yyyy-mm-dd'});
		});

		$(".flightdetail").slideDown();

		var ticketprice = $("[name='tempTicketPrice']").val();
		$("[name='ticketprice']").val(ticketprice);

	});
</script>