<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
<div class="container">
	<div class="marketing">
		<h1>Escape - Tour</h1>
		<p class="marketing-byline">Search best tour, best price at the right time</p>
		<div class="row-fluid">
			<%
			String query = "SELECT tourid, tourimage, cityfromid, mcf.cityname AS CityFromName, mcd.cityname AS CityDestinationName, startdate, enddate, FORMAT(startdate,'Long Date') as convStartDate, FORMAT(enddate,'Long Date') as convEndDate, capacity, mt.description, price, ispromo FROM mstour AS mt, mscity as mcf, mscity as mcd where mcf.cityid=mt.cityfromid And mcd.cityid=mt.citydestinationid";

			String cityfrom = request.getParameter("ddlCityFromT");
			String citydest = request.getParameter("ddlCityDestinationT");
			String dateflight = request.getParameter("ddlMonth");

			if(cityfrom != null)
			query +=" AND cityfromid = "+cityfrom;

			if(citydest != null)
			query +=" AND citydestinationid = "+citydest;

			if(dateflight != null)
			query +=" AND '"+dateflight+"' >= DATEPART('M', mt.StartDate) AND '"+dateflight+"' <= DATEPART('M',mt.EndDate)";
			
			ResultSet rs = st.executeQuery(query);
			Integer promo =0;
			Integer i=1;
			while(rs.next())
			{
			promo = rs.getInt("ispromo");
			%>
			<div class="span9 tour-content">
				<div class="span3">
					<img src="<%=rs.getString("tourimage")%>" style="width:160px;height:200px;">
				</div>
				<div class="span6">
					<form method="POST" action="tourdetail.jsp">
						<p style="display:none;">
							<input type="hidden" value="<%=rs.getString("tourid")%>" name="tourid" />
						</p>
						<h4 style="color:#ff9a25">
							<%=rs.getString("CityFromName")%> &nbsp;-&nbsp;<%=rs.getString("CityDestinationName")%> 
						</h4>
						<p>
							<%=rs.getString("convStartDate")%> &nbsp;-&nbsp;<%=rs.getString("convEndDate")%> 
						</p>
						<p>
							<%=rs.getString("description")%>
						</p>
						<p>
							Capacity left: <%=rs.getString("capacity")%>
						</p>
						<p>
							<%=rs.getString("price")%>
							<%if(promo== 1) out.print("<label style='color:red; display:inline;' class='blink'>IN PROMO</label>");%>
						</p>
						<p>
							<input type="submit" class="btn btn-primary" value="View Detail" />
						</p>
					</form>
				</div>
			</div>
			<div style="clear:both"/>
			<%
			i++;
			}
			%>
		</div>
	</div>
</div> <!-- </container> end of content -->

<%@ include file="footer.jsp" %>