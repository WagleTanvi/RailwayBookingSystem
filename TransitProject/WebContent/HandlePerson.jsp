<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
     		try{
     			ApplicationDB db = new ApplicationDB();	
	    		Connection con = db.getConnection();
	    		Statement stmt = con.createStatement();
	    		String fname = request.getParameter("fname");
	    		String zipcode = request.getParameter("zipcode");
	    		String email = request.getParameter("email");
	    		String lname = request.getParameter("lname");
	    		String telephone = request.getParameter("telephone");
	    		String city = request.getParameter("city");
	    		String state = request.getParameter("state");
	    		String ssn = request.getParameter("ssn");
	    		String role = request.getParameter("role");
	    		String user = (String) session.getAttribute("user");

	    		if (fname == "" || zipcode == "" || email == "" || lname == "" || telephone == "" || city == "" || state == "" || ssn == "" || fname == null || zipcode == null || email == null || lname == null || telephone == null || city == null || state == null || ssn == null){
	    			out.println("<h1 style='color:red'> Fields cannot be empty </h1> <a href='index.jsp'>Click here to try again</a>");
	    		}
	    		
	    		String statement = "UPDATE users SET fname=?, lname=?, telephone=?, city=?, state=?, zipcode=?, email=?, role=?, ssn=? WHERE username=?";
	    		PreparedStatement ps = con.prepareStatement(statement);
    	    	ps.setString(1, fname);
    	    	ps.setString(2, lname);
    	    	ps.setString(3, telephone);
    	    	ps.setString(4, city);
    	    	ps.setString(5, state);
    	    	ps.setString(6, zipcode);
	    		ps.setString(7, email);
	    		ps.setString(8, role);
	    		ps.setString(9, ssn);
	    		ps.setString(10, user);
    	    	int x = ps.executeUpdate();
    	    	
    	    	if (x == 1){
    	    		if(session.getAttribute("role").equals("administrator")){
    	    			response.sendRedirect("People.jsp");
    	    		}
    	    		else if(request.getParameter("role").equals("customer_service_rep")){
    	    			session.setAttribute("role", "customer_service_rep");
    	    			response.sendRedirect("Home.jsp");
    	    		}
    	    		else if(request.getParameter("role").equals("customer")){
    	    			session.setAttribute("role", "customer");
    	    			response.sendRedirect("Home.jsp");

    	    		}
    	    			response.sendRedirect("Home.jsp");
    	    		}
    	    		
    	    	db.closeConnection(con);
     		}
    	    	catch (SQLException e) {
    				if (e.getSQLState().startsWith("23")){
    					session.invalidate();
    					out.println("<h1 style='color:red'> Sorry, there was an error! Please try again. </h1> <a href='index.jsp'>Click here to try again</a>");
    				}
    			}
    			catch (Exception e) {
    				out.print(e);
    			}
    %>
</body>
</html>
