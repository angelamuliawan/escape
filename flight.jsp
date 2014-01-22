<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>

<div class="container">
	<!-- your content goes here -->
		<div class="marketing">
		<h1>Escape - Flight</h1>
		<p class="marketing-byline">Search Best Flight With The Best Price</p>
		
		<div class="row-fluid">
			
			<div class="span4 offset4">
				<form class="form-horizontal" method="POST" action="flight.jsp">
					Sort By
					<div class="control-group">
						<select name="sort1">
							<option value="AirlineName">Airlines</option>
							<option value="TicketPrice">Price</option>
						</select>
					</div>
					
					<div class="control-group">
						<select name="sort2">
							<option value="ASC">Ascending</option>
							<option value="DESC">Descending</option>
						</select>
					</div>
					
					<input class="btn btn-primary" value="Sort Flight" type="submit">

				</form>
			</div>
			
	
			<table class="table table-bordered table-condensed">
				<thead>
					<tr>
						<th>Airlines</th>
						<th>Route</th>
						<th>Price</th>
						<th>Date</th>
						<th>Time</th>
						<th>Capacity</th>
						<th>Quantity</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>

				<%
				
				String sort1 = request.getParameter("sort1");
				String sort2 = request.getParameter("sort2");
				
				String query = "SELECT ma.airlineid, ma.airlinename,  airlineimage, flightid, cityfromid, mcf.cityname AS CityFrom, citydestinationid, mcd.cityname AS CityDestination, date, FORMAT(date,'Long Date') as convDate, time, ticketprice, capacity, ispromo FROM msflight mf, msairline ma, mscity mcf, mscity mcd where mf.airlineid=ma.airlineid AND mcf.cityid=mf.cityfromid AND mcd.cityid=mf.citydestinationid";

				String cityfrom = request.getParameter("ddlCityFrom");
				String citydest = request.getParameter("ddlCityDestination");
				String dateflight = request.getParameter("dateFlight");

				if(cityfrom != null)
				query +=" AND cityfromid = "+cityfrom;

				if(citydest != null)
				query +=" AND citydestinationid = "+citydest;

				if(dateflight != null)
				query +=" AND date = '"+dateflight+"'";

				if(sort1 != null && sort2 != null)
					query += " ORDER BY "+sort1+" "+sort2+" ";
				
				Integer i = 0;
				Integer promo = 0;
				ResultSet rs = st.executeQuery(query);
				while(rs.next())
				{
					i++;
					promo = rs.getInt("ispromo");
				%>
					<form method="GET" action="buyticket.jsp">
						<tr <% if(promo == 1) out.print("class='error'");%> >
							<input type="hidden" name="flightId" value="<%=rs.getString("flightid")%>" />
							<td><img src="<%=rs.getString("airlineimage")%>" style="width:170px;height:50px;"></td>
							<td>
								<h4 style="color:#ff9a25"><%=rs.getString("CityFrom")%> - <%=rs.getString("CityDestination")%></h4>
							</td>
							<td>
								Rp &nbsp; <%=rs.getString("ticketprice")%>
								<%
									if(promo == 1) out.print("<label style='color:red; display:inline;' class='blink'>PROMO</label>");
								%>
							</td>
							<td><%=rs.getString("convDate")%></td>
							<td> <%=rs.getString("time")%></td>
							<td><%=rs.getString("capacity")%></td>
							<td>
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
							</td>
							
							<td>
								<input type="submit" class="btn btn-primary" value="Buy Ticket" />
							</td>
						</tr>
					</form>
				<%
					}
				%>
				</tbody>
			</table>
		</div>
	</div>
</div> <!-- </container> end of content -->

<%@ include file="footer.jsp" %>