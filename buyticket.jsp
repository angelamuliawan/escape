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
					<form class="form-horizontal" action="do/dobuyticket.jsp" method="POST">
						<legend>Flight Confirmation</legend>
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
		var ticketprice = $("[name='tempTicketPrice']").val();
		$("[name='ticketprice']").val(ticketprice);

	});
</script>