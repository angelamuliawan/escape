<%@ include file="connect.jsp" %>

<%
	String userid = (String)session.getAttribute("userid");
	String userheaderid = request.getParameter("userheaderid");
	String username = (String)session.getAttribute("username");
	String password = request.getParameter("txtPassword");
	String paymentprice = request.getParameter("ticketprice");
	Integer hasconfirm = 0; 
	
	// check if flight.jsp was accessed before
	String flightId = request.getParameter("flightId");
	String ticketQuantity = request.getParameter("ddlTicketQuantity");
	Integer tempTicket = Integer.parseInt(ticketQuantity);


	String query = "SELECT UserName FROM MsUser WHERE UserName = '"+ username +"' AND Password = '"+password+"' ";
	ResultSet rs = st.executeQuery(query);

	if(rs.next()) {
		if(flightId != null && ticketQuantity != null) {
			st.executeUpdate("INSERT INTO TrPaymentFlight(UserID, FlightID, Quantity, PaymentPrice, HasConfirm)" + 
			"VALUES('"+userid+"','"+flightId+"',"+ticketQuantity+","+paymentprice+","+hasconfirm+")");

			st.executeUpdate("UPDATE MsFlight SET Capacity = (Capacity - "+tempTicket+") WHERE FlightID = " + flightId);

			for(Integer i = 0; i < tempTicket; i++) {
				String passenger = (String)request.getParameter("fullname" + i);
				String birthdate = (String)request.getParameter("birthdate" + i);
				String genderid = (String)request.getParameter("gender" + i);
				String identitynumber = (String)request.getParameter("identitynumber" + i);

				st.executeUpdate("INSERT INTO TrPaymentFlightDetail(PaymentFlightID, FullName, BirthDate," + 
				"GenderID,IdentityNumber) " +
				"VALUES("+userheaderid+", '"+passenger+"','"+birthdate+"', "+genderid+" , '"+identitynumber+"')");
			}
			response.sendRedirect("../index.jsp?status=Flight transaction success");
			con.close();
		}
		
	}
	
	else {
		response.sendRedirect("../buyticket.jsp?err=Invalid password&&flightId="+flightId+"&&ddlTicketQuantity=" + ticketQuantity);
	}	
%>