<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In/Register</title>
</head>
<body>
	 <%
     	String type = request.getParameter("command");
     	session.setAttribute("type", type);
     	session.setAttribute("filterRole", "all");
     	if (type.equals("register")){
     		out.println("<h1> Register Page: </h1>");
     	}
     	else if (type.equals("login")){
     		out.println("<h1> Login Page: </h1>");
     	}
     %>
     <form action="HandleLoginDetails.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
     	<input type="submit" value="Submit"/>
     </form>
     

	
</body>
</html>
