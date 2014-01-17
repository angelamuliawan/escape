<%@ include file="connect.jsp" %>

<%
	/* Get all required parameter */
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String confirmPassword = request.getParameter("confirmPassword");
	String email = request.getParameter("email");
	String fullname = request.getParameter("fullname");
	String birthdate = request.getParameter("date");
	String genderid = request.getParameter("gender");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	String mobilephone = request.getParameter("mobilephone");
	String news = request.getParameter("newsletter");
	
	Integer newsletter = 0;
	if(news != null) newsletter = Integer.parseInt(news);

	Integer gender = 0;
	if(genderid != null) gender = Integer.parseInt(genderid);
	
	boolean PhoneValid = true;
	if(phone!="") {
		for(Integer i = 0; i < phone.length();i++) {
			if(!Character.isDigit(phone.charAt(i))) {
				PhoneValid = false;
				break;
			}
		}
	}

	boolean MobilePhoneValid = true;
	if(mobilephone!="") {
		for(Integer i = 0; i < mobilephone.length();i++) {
			if(!Character.isDigit(mobilephone.charAt(i))) {
				MobilePhoneValid = false;
				break;
			}
		}
	}
	
	String[] x = email.split("@");
	String[] y = email.split("\\.");
	
	/* validate empty field */
	if(username.equals("") || email.equals("") || password.equals("") || confirmPassword.equals("") || gender == 0 || address.equals("") || phone.equals("")  || mobilephone.equals("") || fullname.equals("") || birthdate.equals("")  ) {
		response.sendRedirect("../register.jsp?err=Each field must be filled");
	}
	
	/* validate email */
	else if(email.indexOf("@") >= email.indexOf(".")){
		response.sendRedirect("../register.jsp?err=Invalid email format");
	}
	
	/* validate email */
	else if(x.length!=2 || y.length!=2) {
		response.sendRedirect("../register.jsp?err=Invalid email format");
	}
	
	/* validate email */
	else if(email.indexOf("@") == 0 || email.indexOf("@")+1 == email.indexOf(".")) {
		response.sendRedirect("../register.jsp?err=Invalid email format");
	}

	/* validate password */
	else if(!password.equals(confirmPassword)){
		response.sendRedirect("../register.jsp?err=Password didn't match");
	}
	
	/* validate phone */
	else if(PhoneValid == false){
		response.sendRedirect("../register.jsp?err=Invalid phone format");
	}

	/* validate mobile phone */
	else if(MobilePhoneValid == false){
		response.sendRedirect("../register.jsp?err=Invalid mobile phone format");
	}
	
	else
	{
		String query = "SELECT UserName FROM msuser WHERE UserName = '"+ username +"' ";
		ResultSet rs = st.executeQuery(query);
		
		/* Check if user is exists */
		if(rs.next()) {
			response.sendRedirect("../register.jsp?err=Username has been used by another member");
		}
		else {	
			st.executeUpdate("INSERT INTO Msuser(UserName, Password, FullName, GenderID, BirthDate, Phone, MobilePhone, Address, Email, isNewsLetter) VALUES" + 
			"('"+username+"','"+password+"','"+fullname+"',"+gender+",'"+birthdate+"','"+phone+"','"+mobilephone+"','"+address+"','"+email+"',"+newsletter+")");
			con.close();	
			response.sendRedirect("../register.jsp?status=You are successfully registered. Please try to login");
		}
	}
%>