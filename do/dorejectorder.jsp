<%@ include file="connect.jsp" %>

<%
	/* Get all required parameter */
	String tempid = request.getParameter("id");
	String orderType = request.getParameter("type");
	Integer id = Integer.parseInt(tempid);
	
	// check what order is being confirmed
	if(orderType.compareTo("Flight") == 0)
		st.executeUpdate("UPDATE TrPaymentFlight SET hasConfirm = 3 WHERE PaymentFlightID = " + id);
	else if(orderType.compareTo("Hotel") == 0)
		st.executeUpdate("UPDATE TrPaymentHotel SET hasConfirm = 3 WHERE PaymentHotelID = " + id);
	else if(orderType.compareTo("Tour") == 0)
		st.executeUpdate("UPDATE TrPaymentTour SET hasConfirm = 3 WHERE PaymentTourID = " + id);
	
	con.close();		
	response.sendRedirect("../confirmation.jsp");
%>