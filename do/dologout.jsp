<%@include file = "connect.jsp"%> 
<% 
	/* remove all session */
	session.invalidate();
	response.sendRedirect("../index.jsp");
%>