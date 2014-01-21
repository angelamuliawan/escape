<%@ include file="connect.jsp" %>

<%
	/* Get all required parameter */
	String temphotelid = request.getParameter("hotelid");
	String tempcurUserID = (String)session.getAttribute("userid");
	String tempscore = request.getParameter("score");
	
	Integer hotelid = Integer.parseInt(temphotelid);
	Integer curUserID = Integer.parseInt(tempcurUserID);
	Integer score = Integer.parseInt(tempscore);
	
	String query = "INSERT INTO TrHotelRating(UserID, HotelID, Rating) VALUES(" + curUserID + "," + hotelid + "," + score + ")";
	st.executeUpdate(query);
	con.close();
	response.sendRedirect("../hoteldetail.jsp?hotelid=" + hotelid);	
%>