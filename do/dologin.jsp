<%@include file = "connect.jsp"%> 
<% 
	String username = request.getParameter("txtUsername"); 
	String password = request.getParameter("txtpassword"); 
	
	String query = "select * from mscustomer where username='"+username+"' and password='"+password+"'"; 
	ResultSet rs = st.executeQuery(query); 
		if(rs.next()) 
		{ 
			session.setAttribute("username",username);
			session.setAttribute("password",password);
			response.sendRedirect("../index.jsp"); 
		} 
		else 
		{ 
			response.sendRedirect("../index.jsp?err=Invalid Username or Password"); 
		} 
%>