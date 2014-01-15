<%@ include file="connect.jsp" %>

<%
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	String password = request.getParameter("txtPassword");
	String paymentprice = request.getParameter("ticketprice");
	Integer hasconfirm = 0; 
	
	// check if flight.jsp was accessed before
	String flightId = request.getParameter("flightId");
	String ticketQuantity = request.getParameter("ddlTicketQuantity");

	String query = "SELECT UserName FROM MsUser WHERE UserName = '"+ username +"' AND Password = '"+password+"' ";
	ResultSet rs = st.executeQuery(query);
	
	if(rs.next()) {
		if(flightId != null && ticketQuantity != null) {
			
			st.executeUpdate("INSERT INTO TrPaymentFlight(UserID, FlightID, Quantity, PaymentPrice, HasConfirm)" + 
			"VALUES('"+userid+"','"+flightId+"',"+ticketQuantity+","+paymentprice+","+hasconfirm+")");
			
			response.sendRedirect("../index.jsp?status=Flight transaction success");

			con.close();
		}
	}
	
	else {
		response.sendRedirect("../buyticket.jsp?err=Invalid password&&flightId="+flightId+"&&ddlTicketQuantity=" + ticketQuantity);
	}	
%>