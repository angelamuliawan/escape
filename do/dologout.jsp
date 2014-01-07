<%@include file = "connect.jsp"%> 
<% 
	session.invalidate();
	response.sendRedirect("../index.jsp");
%>