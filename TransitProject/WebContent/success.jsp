<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		/*out.println(request.getParameter("schedule"));
		out.println(session.getAttribute("origin"));
		out.println(session.getAttribute("destination"));*/
		if (session.getAttribute("type").equals("register")){ %>
			<h1>Welcome <%out.println("<span style='color:blue'>"+session.getAttribute("user")+"</span>.");%> Successfully Registered and logged in!</h1>
			<a href='logout.jsp'>Log out</a>
		<% }
		else if (session.getAttribute("type").equals("login")){ %>
			<h1>Welcome back <%out.println("<span style='color:blue'>"+session.getAttribute("user")+"</span>.");%> Successfully Logged In!</h1>
			<a href='logout.jsp'>Log out</a>
		<% }
	%>
	
</body>
</html>