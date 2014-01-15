<%@ include file="connect.jsp" %>

<%
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	String password = request.getParameter("txtPassword");
	String tourprice = request.getParameter("tourprice");
	Integer hasconfirm = 0; 
	
	// check if flight.jsp was accessed before
	String tourid = request.getParameter("tourid");
	String tourQuantity = request.getParameter("ddlTourQuantity");

	String query = "SELECT UserName FROM MsUser WHERE UserName = '"+ username +"' AND Password = '"+password+"' ";
	ResultSet rs = st.executeQuery(query);
	
	if(rs.next()) {
		if(tourid != null && tourQuantity != null) {
			
			st.executeUpdate("INSERT INTO TrPaymentTour(UserID, TourID, Quantity, PaymentPrice, HasConfirm)" + 
			"VALUES('"+userid+"','"+tourid+"',"+tourQuantity+","+tourprice+","+hasconfirm+")");
			
			response.sendRedirect("../index.jsp?status=Success");

			con.close();
		}
	}
	
	else {
		response.sendRedirect("../booktour.jsp?err=Invalid password&&tourid="+tourid+"&&ddlTourQuantity=" + tourQuantity);
	}	
%>