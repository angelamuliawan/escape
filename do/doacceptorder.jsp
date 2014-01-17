<%@ include file="connect.jsp" %>

<%
	String tempid = request.getParameter("id");
	String orderType = request.getParameter("type");
	Integer id = Integer.parseInt(tempid);
	
	if(orderType.compareTo("Flight") == 0)
		st.executeUpdate("UPDATE TrPaymentFlight SET hasConfirm = 2 WHERE PaymentFlightID = " + id);
	else if(orderType.compareTo("Hotel") == 0)
		st.executeUpdate("UPDATE TrPaymentHotel SET hasConfirm = 2 WHERE PaymentHotelID = " + id);
	else if(orderType.compareTo("Tour") == 0)
		st.executeUpdate("UPDATE TrPaymentTour SET hasConfirm = 2 WHERE PaymentTourID = " + id);
	
	con.close();		
	response.sendRedirect("../confirmation.jsp");
		
%>