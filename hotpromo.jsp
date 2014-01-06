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
				<div class="span8" style="text-align:left">
					<p>
						<a href="promodetail.jsp?id=<%=rs.getString("PromoAndEventID")%> "><h3><%=rs.getString("Title")%></h3></a>
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