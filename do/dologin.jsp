<%@include file = "connect.jsp"%> 
<% 
	String username = request.getParameter("txtUsername"); 
	String password = request.getParameter("txtPassword"); 
	
	// check if flight.jsp was accessed before
	String flightId = request.getParameter("flightId");
	String ticketQuantity = request.getParameter("ddlTicketQuantity");

	// check if tour.jsp was accessed before
	String tourid = request.getParameter("tourid");
	String tourquantity = request.getParameter("ddlTourQuantity");
	
	String query = "select * from MsUser where username='"+username+"' and password='"+password+"'"; 
	ResultSet rs = st.executeQuery(query); 
		if(rs.next()) 
		{ 
			session.setAttribute("userid", rs.getString("userid"));
			session.setAttribute("username",username);
			session.setAttribute("password",password);
			
			if(flightId != null && ticketQuantity != null)
				response.sendRedirect("../buyticket.jsp?flightId="+flightId+"&&ddlTicketQuantity=" + ticketQuantity);
			
			else if(tourid != null && tourquantity != null)
				response.sendRedirect("../booktour.jsp?tourid="+tourid+"&&ddlTourQuantity=" + tourquantity);

			else {
				response.sendRedirect("../index.jsp");
			}
		} 
		else 
		{
			if(flightId != null && ticketQuantity != null)
				response.sendRedirect("../buyticket.jsp?err=Invalid Username or Password&&flightId="+flightId+"&&ddlTicketQuantity=" + ticketQuantity);

			else if(tourid != null && tourquantity != null)
				response.sendRedirect("../booktour.jsp?err=Invalid Username or Password&&tourid="+tourid+"&&ddlTourQuantity=" + tourquantity);

			else {
				response.sendRedirect("../index.jsp?err=Invalid Username or Password"); 
			}
		} 
%>