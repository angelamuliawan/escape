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

			ResultSet rs = st.executeQuery(query);
			Integer promo =0;
			Integer i=1;
			while(rs.next())
			{
			promo = rs.getInt("ispromo");
			%>
			<div class="span7 tour-content">
				<div class="span3">
					<img src="assets/img/tourimage/<%=i%>.jpg" style="width:160px;height:200px;">
				</div>
				<div class="span4">
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
