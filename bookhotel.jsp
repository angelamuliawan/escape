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
					Integer classid = Integer.parseInt(request.getParameter("classid"));
					Integer hotelid = Integer.parseInt(request.getParameter("hotelid"));
					Integer qty = Integer.parseInt(request.getParameter("ddlTicketQuantity"));
					String startdateold = request.getParameter("startdate");
					String enddateold = request.getParameter("enddate");
					
					DateFormat old = new SimpleDateFormat("yyyy-MM-dd");
					Date dateoldstart = old.parse(startdateold);
					Date dateoldend = old.parse(enddateold);
					
					DateFormat df = new SimpleDateFormat("EEEE, dd MMMM yyyy");
					String startdate = df.format(dateoldstart);
					String enddate = df.format(dateoldend);

				%>

				<% if(session.getAttribute("username") == null || session.getAttribute("username") == "") { %>
					<form id="formBookHotel" class="form-horizontal" action="do/dologin.jsp" method="post">
						<legend>Login Form</legend>
						<input type="hidden" name="classid" value="<%=classid%>" />
						<input type="hidden" name="hotelid" value="<%=hotelid%>" />
						<input type="hidden" name="qty" value="<%=qty%>" />
						<input type="hidden" name="startdate" value="<%=startdateold%>" />
						<input type="hidden" name="enddate" value="<%=enddateold%>" />
						<div class="alert alert-info">
							Please login first before start booking hotel. If you're not a member, please <a href="register.jsp">register</a>
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
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" placeholder="Input Your Password" name="txtPassword" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Sign in</button>
						</div>
					</form>
				<% } else { %>
					<form id="formBookHotel" class="form-horizontal" action="do/dobookhotel.jsp" method="POST">
						<legend>Tour Booking Confirmation</legend>
						<input type="hidden" name="classid" value="<%=classid%>" />
						<input type="hidden" name="hotelid" value="<%=hotelid%>" />
						<input type="hidden" name="qty" value="<%=qty%>" />
						<input type="hidden" name="startdate" value="<%=startdateold%>" />
						<input type="hidden" name="enddate" value="<%=enddateold%>" />
						<input type="hidden" name="totalhotel" value="" />
						<div class="control-group">
							<label class="control-label">Username</label>
							<div class="controls">
								<input type="text" disabled name="txtUsername" value="<%=session.getAttribute("username")%>" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Password</label>
							<div class="controls">
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" placeholder="Input Your Password" name="txtPassword" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Book Hotel</button>
						</div>
					</form>
				<% } %>
			</div>
		
			<div class="span6">
				<form class="form-horizontal">
					<legend>Hotel Summary Order</legend>
					<%
					
					String query = "SELECT mhc.hotelid, hotelname, mhc.hotelclassid, hotelclassname, mc.cityname, mco.countryname, address, pricepernight, hotelclassurl FROM mshotelclass AS mhc, mshotel as mh, mscity as mc, mscountry as mco WHERE mc.cityid=mh.cityid AND mhc.hotelid = mh.hotelid AND mco.countryid = mc.countryid AND mhc.hotelclassid = " + classid;

					ResultSet rs = st.executeQuery(query);
					while(rs.next()) {
					Integer price = rs.getInt("pricepernight");
					//Integer tourprice = Integer.parseInt(oldtourPrice.replace(".",""));
					Integer night = 2;
					Integer total = qty * price * night;
					%>
					<input type="hidden" name="totalhoteltemp" value="<%=total%>" />
						<div class="control-group">
							<label class="control-label">Room Hotel Preview :</label>
							<div class="controls form-text modified">
								<span>
									<img src="<%=rs.getString("hotelclassurl")%>" style="width:350px;height:175px;">
								</span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Hotel Name : </label>
							<div class="controls form-text modified">
								<span><%=rs.getString("hotelname")%></span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Address : </label>
							<div class="controls form-text modified">
								<span><%=rs.getString("address")%>,
									&nbsp;<%=rs.getString("cityname")%>, &nbsp;
									<%=rs.getString("countryname")%>
								</span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Hotel Room Class : </label>
							<div class="controls form-text modified">
								<span><%=rs.getString("hotelclassname")%></span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Price/night : </label>
							<div class="controls form-text modified">
								<span>Rp. <%=price%></span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Day in Hotel : </label>
							<div class="controls form-text modified">
								<span><%=startdate%> - <%=enddate%> (<%=night%> day(s))</span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Quantity of Room : </label>
							<div class="controls form-text modified">
								<span><%=qty%></span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label"><b>Grand Total : </b></label>
							<div class="controls form-text modified">
								<span><b>Rp. <%=total%> </b></span>
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
		var totalhotel = $("[name='totalhoteltemp']").val();
		$("[name='totalhotel']").val(totalhotel);
		$("#formBookHotel").validationEngine();
	});
</script>