<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
<div class="container">
`		<!-- your content goes here -->
	  <div class="marketing">

		<h1>Escape - Tour</h1>
		<p class="marketing-byline">Search best tour, best price at the right time</p>

		<div class="row-fluid">

			<%
			String query = "SELECT tourid, cityfromid, mcf.cityname AS CityFromName, mcd.cityname AS CityDestinationName, startdate, enddate, capacity, mt.description, price, ispromo FROM mstour AS mt, mscity as mcf, mscity as mcd where mcf.cityid=mt.cityfromid And mcd.cityid=mt.citydestinationid";

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
					<img src="assets/img/tourimage/<%=i%>.jpg" style="width:160px;height:200px;">
				</div>
				<div class="span6">
					<p style="display:none;">
						<%=rs.getString("tourid")%>
					</p>
					<h4 style="color:#ff9a25">
						<%=rs.getString("CityFromName")%> &nbsp;-&nbsp;<%=rs.getString("CityDestinationName")%> 
					</h4>
					<p>
						<%=rs.getString("startdate")%> &nbsp;-&nbsp;<%=rs.getString("enddate")%> 
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
						<a href="#" style="font-size:12px;">View detail>></a>
					</p>
				</div>
			</div>
			<div style="clear:both">

			<%
			i++;
			}
			%>
		</div>
		
	</div>
</div> <!-- </container> end of content -->

<%@ include file="footer.jsp" %>