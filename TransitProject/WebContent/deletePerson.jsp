<!-- Written By: Zaid Meer zsm7 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Table with database</title>
</head>
<body>

<%
     		try{
     			ApplicationDB db = new ApplicationDB();	
	    		Connection con = db.getConnection();
	    		Statement stmt = con.createStatement();
	    		String user = request.getParameter("value");
	    		String statement = "DELETE FROM users WHERE username = ?";
	    		PreparedStatement ps = con.prepareStatement(statement);
    	    	ps.setString(1, user);
    	    	int x = ps.executeUpdate();
    	    	
    	    	if (x == 1){
    	    			session.setAttribute("filterRole", "all");
    	    			response.sendRedirect("People.jsp");
    	    		}
    	    		
    	    	db.closeConnection(con);
     		}
    	    	catch (SQLException e) {
    				if (e.getSQLState().startsWith("23")){
    					session.invalidate();
    					out.println("<h1 style='color:red'> Sorry, there was an error! Please try again! </h1> <a href='People.jsp'>Click here to try again</a>");
    				}
    			}
    			catch (Exception e) {
    				out.print(e);
    			}
    %>
</body>
</html>
