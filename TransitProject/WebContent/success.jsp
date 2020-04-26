<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Enumeration"%>
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
		Enumeration<String> attributes = request.getSession().getAttributeNames();
		while (attributes.hasMoreElements()) {
		    String attribute = (String) attributes.nextElement();
		    out.println(attribute+" : "+request.getSession().getAttribute(attribute));
		}
	%>
	
</body>
</html>