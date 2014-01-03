<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<%
	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	Connection con = DriverManager.getConnection("jdbc:odbc:driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=" + application.getRealPath("../escape/WEB-INF/escapetour.accdb")); 
	Statement st = con.createStatement(1004,1008);
%>