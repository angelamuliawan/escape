<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
<div class="container">
		<!-- your content goes here -->
	<%
		String id = request.getParameter("tourid");
		Integer tourid = 0;
		if(id != null) tourid = Integer.parseInt(id);
	%>
	<div class="span11 hotel-content">
		<%
			String query = "SELECT tourid, tourimage, cityfromid, daydetail, mcf.cityname AS CityFromName, mcd.cityname AS CityDestinationName, startdate, enddate, FORMAT(startdate,'Long Date') as convStartDate, FORMAT(enddate,'Long Date') as convEndDate, capacity, mt.description, price, isPromo FROM mstour AS mt, mscity as mcf, mscity as mcd WHERE mcf.cityid=mt.cityfromid And mcd.cityid=mt.citydestinationid AND mt.tourid = " + tourid;
			ResultSet rs1 = st.executeQuery(query);
			Integer promo = 0;
			
			
			Integer flag = 1;
			while(rs1.next())
			{
			promo = rs1.getInt("isPromo");
			String daydetail = rs1.getString("daydetail");
			String [] splitDayDetail = daydetail.split("#");
			%>
			<div class="span4">
				<img src="<%=rs1.getString("tourimage")%>" style="width:300px;height:300px;"/>
			</div>
			<div class="span6">
					<p style="display:none;">
						<%=rs1.getString("tourid")%>
					</p>
					<h4 style="color:#ff9a25">
						<%=rs1.getString("CityFromName")%> &nbsp;-&nbsp;<%=rs1.getString("CityDestinationName")%> 
					</h4>
					<p>
						<%=rs1.getString("convStartDate")%> &nbsp;-&nbsp;<%=rs1.getString("convEndDate")%> 
					</p>
					<p>
						<%=rs1.getString("description")%>
					</p>
					<p>
						Capacity left: <%=rs1.getString("capacity")%>
					</p>
					<p>
						Rp. <%=rs1.getString("price")%>
						<%if(promo == 1) out.print("<label style='color:red; display:inline;' class='blink'>IN PROMO</label>");%>
					</p>
					<p>
						<select style="width:auto;" name="ddlTicketQuantity">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
						</select>
						<input type="submit" value="Booking" class="btn btn-primary" style="margin-top:-10px;" />
					</p>
			</div>
			<div style="clear:both">
				<br>
				<%
					for(Integer i = 0; i < splitDayDetail.length; i++) {
				%>
					<h5 style="color:#ff9a25">Day <%=i+1%></h5>
					<p>
						<%=splitDayDetail[i]%>
					</p>
				<%}%>:
			</div>
		<%
			}
		%>
	</div>
</div> <!-- </container> end of content -->

<%@ include file="footer.jsp" %>