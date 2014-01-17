<%@include file = "connect.jsp"%> 
<% 
	/* Get all required parameter */
	String username = request.getParameter("txtUsername"); 
	String password = request.getParameter("txtPassword"); 
	
	// check if flight.jsp was accessed before
	String flightId = request.getParameter("flightId");
	String ticketQuantity = request.getParameter("ddlTicketQuantity");

	// check if tour.jsp was accessed before
	String tourid = request.getParameter("tourid");
	String tourquantity = request.getParameter("ddlTourQuantity");
	
	// check if bookhotel.jsp was accessed before
	String classid = request.getParameter("classid");
	String hotelid = request.getParameter("hotelid");
	String qty = request.getParameter("qty");

	String startdateold = request.getParameter("startdate");
	String enddateold = request.getParameter("enddate");

	String query = "select * from MsUser where username='"+username+"' and password='"+password+"'"; 
	ResultSet rs = st.executeQuery(query); 
	
	/* if user exists */
	if(rs.next()) 
	{
		/* set session for logged in user */
		session.setAttribute("userid", rs.getString("userid"));
		session.setAttribute("username",username);
		session.setAttribute("password",password);
		session.setAttribute("role",rs.getString("role"));
		
		/* if flight was accessed before, then redirect to flight page */
		if(flightId != null && ticketQuantity != null)
			response.sendRedirect("../buyticket.jsp?flightId="+flightId+"&&ddlTicketQuantity=" + ticketQuantity);
		
		/* if tour was accessed before, then redirect to tour page */
		else if(tourid != null && tourquantity != null)
			response.sendRedirect("../booktour.jsp?tourid="+tourid+"&&ddlTourQuantity=" + tourquantity);
		
		/* if hotel was accessed before, then redirect to hotel page */
		else if(classid != null && hotelid != null && qty != null && startdateold != null && enddateold != null)
			response.sendRedirect("../bookhotel.jsp?classid="+classid+"&&hotelid="+hotelid+"&&ddlTicketQuantity="+qty+"&&startdate="+startdateold+"&&enddate="+enddateold);
		
		else {
			response.sendRedirect("../index.jsp");
		}
	} 
	else 
	{
		/* if flight was accessed before, then redirect to flight page */
		if(flightId != null && ticketQuantity != null)
			response.sendRedirect("../buyticket.jsp?err=Invalid Username or Password&&flightId="+flightId+"&&ddlTicketQuantity=" + ticketQuantity);
		
		
		/* if tour was accessed before, then redirect to tour page */
		else if(tourid != null && tourquantity != null)
			response.sendRedirect("../booktour.jsp?err=Invalid Username or Password&&tourid="+tourid+"&&ddlTourQuantity=" + tourquantity);
		
		/* if hotel was accessed before, then redirect to hotel page */
		else if(classid != null && hotelid != null && qty != null && startdateold != null && enddateold != null)
			response.sendRedirect("../bookhotel.jsp?err=Invalid Username or Password&&classid="+classid+"&&hotelid="+hotelid+"&&ddlTicketQuantity="+qty+"&&startdate="+startdateold+"&&enddate="+enddateold);
		
		else {
			response.sendRedirect("../index.jsp?err=Invalid Username or Password"); 
		}
	} 
%>