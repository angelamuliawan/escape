<%@include file = "connect.jsp"%> 
<% 
	/*
	buat dapetin date
	java.sql.Date sqldate = new java.sql.Date(new java.util.Date().getTime()); 
	DataManager dataManager = new DataManager();
	DateFormat reFormat = new SimpleDateFormat("yyyy-MM-dd");
	*/
	
	String from = request.getParameter("ddlCityFrom"); 
	String destination = request.getParameter("ddlCityDestination");
	//Date dateofflight = (Date)request.getParameter("dateFlight"); 
	String dateofflight = request.getParameter("dateFlight");
	
	out.print(from);
	out.print(destination);
	out.print(dateofflight);
	
	/* String query = "select * from mscustomer where username='"+username+"' and password='"+password+"'"; 
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
		} */
%>