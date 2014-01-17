<%@ include file="connect.jsp" %>

<%
	/* Get all required parameter */
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	String password = request.getParameter("txtPassword");
	Integer hasconfirm = 0; 
	
	// check if bookhotel.jsp was accessed before
	Integer classid = Integer.parseInt(request.getParameter("classid"));
	Integer hotelid = Integer.parseInt(request.getParameter("hotelid"));
	Integer qty = Integer.parseInt(request.getParameter("qty"));
	String startdateold = request.getParameter("startdate");
	String enddateold = request.getParameter("enddate");
	String totalhotel = request.getParameter("totalhotel");

	String query = "SELECT UserName FROM MsUser WHERE UserName = '"+ username +"' AND Password = '"+password+"' ";
	ResultSet rs = st.executeQuery(query);
	
	if(rs.next()) {
		if(classid != null && hotelid != null && qty != null && startdateold != null && enddateold != null)
		{
			st.executeUpdate("INSERT INTO TrPaymentHotel(HotelID, HotelClassID, UserID, StartDate, EndDate, NumberOfRoom, PaymentPrice, HasConfirm)" + 
			"VALUES('"+hotelid+"','"+classid+"','"+userid+"','"+startdateold+"',"+enddateold+","+qty+","+totalhotel+","+hasconfirm+")");
			
			response.sendRedirect("../index.jsp?status=Booking Hotel transaction success, wait for information in the message menu");

			con.close();
		}
	}
	
	else {
		response.sendRedirect("../bookhotel.jsp?err=Invalid password&&classid="+classid+"&&hotelid="+hotelid+"&&ddlTicketQuantity="+qty+"&&startdate="+startdateold+"&&enddate="+enddateold);
	}	
%>