<%@ include file="connect.jsp" %>
<%
	/* Get all required parameters */
	String curPaymentHotelID = request.getParameter("paymenthotelid");
	String bank = request.getParameter("ddlBank");
	String accountname = request.getParameter("accountname");
	String accountnumber = request.getParameter("accountnumber");
	String transferdate = request.getParameter("transferdate");

	/* Execute query */
	st.executeUpdate("UPDATE TrPaymentHotel SET hasConfirm = 1, Bank = '"+bank+"', AccountName = '"+accountname+"', AccountNumber = '"+accountnumber+"', TransferDate = '"+transferdate+"' WHERE PaymentHotelID = "+curPaymentHotelID+" ");
	con.close();
	
	/* redirect to index page */
	response.sendRedirect("../index.jsp?status=Confirmation sent");
%>