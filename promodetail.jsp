<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
<div class="container">
	<%
		String id = request.getParameter("id");
		Integer detailid = 0;
		if(id != null) detailid = Integer.parseInt(id);

		String query = "SELECT * FROM MsPromoAndEvent where PromoAndEventID ="+id;
		
		ResultSet rs = st.executeQuery(query);
		while(rs.next())
		{
			%>
			<h3><%=rs.getString("title")%></h3>
			<p><%=rs.getString("Description")%></p>
			<p><%=rs.getString("ActiveDate")%></p>
			<hr>
			<img src="assets/<%=rs.getString("ImageURL")%>" />
		<%
		}
		%>
</div>
<%@ include file="footer.jsp" %>