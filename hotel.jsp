<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
<div class="container">
`		<!-- your content goes here -->
	  <div class="marketing">

		<h1>Escape - Hotel</h1>
		<p class="marketing-byline">Search Best Hotel With The Best Price</p>

		<div class="row-fluid">

			<%
			String query = "SELECT hotelid, hotelname, phone, address, mh.cityid, mc.cityname, countryname, description, stars, hotelimage, ispromo FROM mshotel mh, mscity mc, mscountry mco where mh.cityid = mc.cityid AND mc.countryid = mco.countryid";

			String hotelname = request.getParameter("searchhotel");
			String hotelcity = request.getParameter("ddlCityHotel");
			String stars = request.getParameter("ddlStars");
/*
			out.print(hotelname);
			out.print(hotelcity);
			out.print(stars);

*/
			if(hotelname != null)
			query +=" AND hotelname like '%"+hotelname+"%'";

			if(hotelcity != null)
			query +=" AND mh.cityid = "+hotelcity;

			if(stars != null )
					query +=" AND stars = "+stars;

			//query += " order by stars desc, ispromo desc";

			Integer i = 0;
			ResultSet rs = st.executeQuery(query);
			while(rs.next())
			{
				i++;
				Integer numstar = rs.getInt("stars");
			%>

			 	<div class="span4 line">
			 		<form method="post" action="hoteldetail.jsp">
			 			<input type="text" value="<%=rs.getString("hotelid")%>" style="display:none;" name="hotelid" />
					  	<h3 style="color:#ff9a25"><%=rs.getString("hotelname")%></h3>
						<img class="marketing-img" src="<%=rs.getString("hotelimage")%>" style="width:220px;height:250px;">
						<h5 style="color:#ff9a25"><%=rs.getString("cityname")%> - <%=rs.getString("countryname")%> 
							<%if(rs.getInt("ispromo") == 1) out.print("<label style='color:red; display:inline;' class='blink'>IN PROMO</label>");%>
						</h5>
						<p>
							<%
								for(int j = 0; j<numstar; j++) out.print("<img src='assets/img/icon/Star.png' width='20' height='20' style='display:inline'>");
								
							%><br>
							<%=rs.getString("description")%>
						</p>
						<input type="submit" class="btn btn-primary" value="View Detail Class Hotel" />
					</form>
			  	</div>
			  	<% if(i!=0 && i%3==0) out.print("<div style='clear:both'/>"); %>
			<%
				}
			%>

		</div>

	</div>
</div> <!-- </container> end of content -->

<%@ include file="footer.jsp" %>