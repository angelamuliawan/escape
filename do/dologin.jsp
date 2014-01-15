<%@include file = "connect.jsp"%> 
<% 
	String username = request.getParameter("txtUsername"); 
	String password = request.getParameter("txtPassword"); 
	
	// check if flight.jsp was accessed before
	String flightId = request.getParameter("flightId");
	String ticketQuantity = request.getParameter("ddlTicketQuantity");
	
	String query = "select * from MsUser where username='"+username+"' and password='"+password+"'"; 
	ResultSet rs = st.executeQuery(query); 
		if(rs.next()) 
		{ 
			session.setAttribute("userid", rs.getString("userid"));
			session.setAttribute("username",username);
			session.setAttribute("password",password);
			
			if(flightId != null && ticketQuantity != null)
				response.sendRedirect("../buyticket.jsp?flightId="+flightId+"&&ddlTicketQuantity=" + ticketQuantity);
			
			else {
				response.sendRedirect("../index.jsp");
			}
		} 
		else 
		{
			if(flightId != null && ticketQuantity != null)
				response.sendRedirect("../buyticket.jsp?err=Invalid Username or Password&&flightId="+flightId+"&&ddlTicketQuantity=" + ticketQuantity);
			else {
				response.sendRedirect("../index.jsp?err=Invalid Username or Password"); 
			}
		} 
%>