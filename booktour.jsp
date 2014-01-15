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
					Integer tourid = Integer.parseInt(request.getParameter("tourid"));
					Integer tourQuantity = Integer.parseInt(request.getParameter("ddlTourQuantity"));
				%>

				<% if(session.getAttribute("username") == null || session.getAttribute("username") == "") { %>
					<form class="form-horizontal" action="do/dologin.jsp" method="post">
						<legend>Login Form</legend>
						<input type="hidden" name="tourid" value="<%=tourid%>" />
						<input type="hidden" name="ddlTourQuantity" value="<%=tourQuantity%>" />
						<div class="alert alert-info">
							Please login first before start buying tour. If you're not a member, please <a href="register.jsp">register</a>
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
					<form class="form-horizontal" action="do/dobooktour.jsp" method="POST">
						<legend>Tour Booking Confirmation</legend>
						<input type="hidden" name="tourid" value="<%=tourid%>" />
						<input type="hidden" name="ddlTourQuantity" value="<%=tourQuantity%>" />
						<input type="hidden" name="tourprice" value="" />
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
							<button type="submit" class="btn btn-primary">Buy Tour</button>
						</div>
					</form>
				<% } %>
			</div>
		
			<div class="span6">

				<form class="form-horizontal">
					<legend>Tour Summary Order</legend>
					<%
					
					String query = "SELECT tourid, tourimage, cityfromid, daydetail, mcf.cityname AS CityFromName, mcd.cityname AS CityDestinationName, startdate, enddate, FORMAT(startdate,'Long Date') as convStartDate, FORMAT(enddate,'Long Date') as convEndDate, capacity, mt.description, price, isPromo FROM mstour AS mt, mscity as mcf, mscity as mcd WHERE mcf.cityid=mt.cityfromid And mcd.cityid=mt.citydestinationid AND mt.tourid = " + tourid;

					ResultSet rs = st.executeQuery(query);
					while(rs.next()) {
					String oldtourPrice = rs.getString("price");
					Integer tourprice = Integer.parseInt(oldtourPrice.replace(".",""));
					Integer total = tourQuantity * tourprice;
					
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
		var tourprice = $("[name='tempTourPrice']").val();
		$("[name='tourprice']").val(tourprice);

	});
</script>