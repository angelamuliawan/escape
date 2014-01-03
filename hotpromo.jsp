<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
<div class="container">
`		<!-- your content goes here -->
	  <div class="marketing">

		<h1>Escape - Promo</h1>
		<p class="marketing-byline">Search Our Promo Event & News</p>

		<div class="row-fluid">
			<%
			String query = "SELECT * FROM MsPromoAndEvent";

			ResultSet rs = st.executeQuery(query);
			Integer i=1;
			while(rs.next())
			{
			%>
			<div class="span12">
				<div class="span4">
					<img src="assets/<%=rs.getString("ImageURL")%>" style="width:250px;height:200px;">
				</div>
				<div class="span8">
					<p style="display:none;">
						<%=rs.getString("PromoAndEventID")%> 
					</p>
					<p>
						<h3><%=rs.getString("Title")%></h3>
					</p>
					<p>
						 <%=rs.getString("ActiveDate")%>
					</p>
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
