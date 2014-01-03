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
				  		<td><input type="submit" class="btn btn-primary" value="Buy Ticket" /></td>
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

<!-- included manually, not from bootstrap -->
<script src="assets/js/pagejs/register.js" type="text/javascript"></script>

<!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap-transition.js"></script>
    <script src="assets/js/bootstrap-alert.js"></script>
    <script src="assets/js/bootstrap-modal.js"></script>
    <script src="assets/js/bootstrap-dropdown.js"></script>
    <script src="assets/js/bootstrap-scrollspy.js"></script>
    <script src="assets/js/bootstrap-tab.js"></script>
    <script src="assets/js/bootstrap-tooltip.js"></script>
    <script src="assets/js/bootstrap-popover.js"></script>
    <script src="assets/js/bootstrap-button.js"></script>
    <script src="assets/js/bootstrap-collapse.js"></script>
    <script src="assets/js/bootstrap-carousel.js"></script>
    <script src="assets/js/bootstrap-typeahead.js"></script>
    <script src="assets/js/bootstrap-affix.js"></script>
    <script src="assets/js/holder/holder.js"></script>
    <script src="assets/js/google-code-prettify/prettify.js"></script>
    <script src="assets/js/application.js"></script>
	
	<script>
		/*$(document).ready(function(){
			$("#ddlCityFrom").change(function(){
				//var id = $("#ddlCityFrom").val();
				//alert($(this).siblings("#ddlCityDestination option:selected").val());
				
			});
		});*/
	</script>