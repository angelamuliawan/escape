<%@ include file="connect.jsp" %>

<%
	/* Get all required parameter */
	String userid = (String)session.getAttribute("userid");
	String userheaderid = request.getParameter("userheaderid");
	String username = (String)session.getAttribute("username");
	String password = request.getParameter("txtPassword");
	String tourprice = request.getParameter("tourprice");
	Integer hasconfirm = 0; 
	
	// check if flight.jsp was accessed before
	String tourid = request.getParameter("tourid");
	String tourQuantity = request.getParameter("ddlTourQuantity");
	Integer tempTicket = Integer.parseInt(tourQuantity);

	String query = "SELECT UserName FROM MsUser WHERE UserName = '"+ username +"' AND Password = '"+password+"' ";
	ResultSet rs = st.executeQuery(query);
	
	/* if user exists */
	if(rs.next()) {
		if(tourid != null && tourQuantity != null) {
			
			/* Insert into database */
			st.executeUpdate("INSERT INTO TrPaymentTour(UserID, TourID, Quantity, PaymentPrice, HasConfirm)" + 
			"VALUES('"+userid+"','"+tourid+"',"+tourQuantity+","+tourprice+","+hasconfirm+")");
			
			/* Reduce capacity based on quantity ordered */
			st.executeUpdate("UPDATE MsTour SET Capacity = (Capacity - "+tempTicket+") WHERE TourID = " + tourid);

			/* Insert detail */
			for(Integer i = 0; i < tempTicket; i++) {
				String passenger = (String)request.getParameter("fullname" + i);
				String birthdate = (String)request.getParameter("birthdate" + i);
				String genderid = (String)request.getParameter("gender" + i);
				String identitynumber = (String)request.getParameter("identitynumber" + i);

				st.executeUpdate("INSERT INTO TrPaymentTourDetail(PaymentTourID, FullName, BirthDate," + 
				"GenderID,IdentityNumber) " +
				"VALUES("+userheaderid+", '"+passenger+"','"+birthdate+"', "+genderid+" , '"+identitynumber+"')");
			}
			
			response.sendRedirect("../index.jsp?status=Tour transaction success");
			con.close();
		}
	}
	
	else {
		response.sendRedirect("../booktour.jsp?err=Invalid password&&tourid="+tourid+"&&ddlTourQuantity=" + tourQuantity);
	}	
%>