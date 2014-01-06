<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
<div class="container">
`		<!-- your content goes here -->
	  <div class="marketing">

		<h1>Escape - Flight</h1>
		<p class="marketing-byline">Search Best Flight With The Best Price</p>

		<div class="row-fluid">
			<table class="table table-bordered table-condensed">
				<thead>
					<tr>
						<th>
							Airlines
						</th>
						<th>
							Route
						</th>
						<th>
							Price
						</th>
						<th>
							Date
						</th>
						<th>
							Time
						</th>
						
						<th>
							Time
						</th>
					</tr>
				</thead>
				<tbody>

			<%
			String query = "SELECT ma.airlineid, ma.airlinename,  airlineimage, flightid, cityfromid, mcf.cityname AS CityFrom, citydestinationid, mcd.cityname AS CityDestination, date, time, ticketprice, capacity, ispromo FROM msflight mf, msairline ma, mscity mcf, mscity mcd where mf.airlineid=ma.airlineid AND mcf.cityid=mf.cityfromid AND mcd.cityid=mf.citydestinationid";

			String cityfrom = request.getParameter("ddlCityFrom");
			String citydest = request.getParameter("ddlCityDestination");
			String dateflight = request.getParameter("dateFlight");

			//out.print(cityfrom);
			//out.print(citydest);
			//out.print(dateflight);


			if(cityfrom != null)
			query +=" AND cityfromid = "+cityfrom;

			if(citydest != null)
			query +=" AND citydestinationid = "+citydest;

			if(dateflight != null)
			query +=" AND date = '"+dateflight+"'";

			query += " order by ticketprice asc, ispromo desc";

			Integer i = 0;
			Integer promo = 0;
			ResultSet rs = st.executeQuery(query);
			while(rs.next())
			{
				i++;
				promo = rs.getInt("ispromo");
			%>

  				  	<tr <% if(promo == 1) out.print("class='error'");%> >
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
				  		<td><%=rs.getString("date")%></td>
				  		<td> <%=rs.getString("time")%></td>
				  		<td><%=rs.getString("capacity")%></td>
				  		<td><a href="buyticket.jsp" class="btn btn-primary">Buy Ticket</a></td>
				  	</tr>
			<%
				}
			%>
			</tbody>
		</table>

		</div>

	</div>
</div> <!-- </container> end of content -->

<%@ include file="footer.jsp" %>