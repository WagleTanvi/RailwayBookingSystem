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
	    		String username = request.getParameter("username");
	    		String password = request.getParameter("password");
	    		if (username == "" || password == "" || username == null || password == null ){
	    			out.println("<h1 style='color:red'> Username/Password cannot be empty </h1> <a href='index.jsp'>Click here to try again</a>");
	    		}
	    		else if (session.getAttribute("type").equals("register")){
    	    		
    	    		String statement = "INSERT INTO users (username,password)"+ "VALUES (?,?)";
    	    		PreparedStatement ps = con.prepareStatement(statement);
    	    		ps.setString(1, username);
    	    		ps.setString(2, password);		
    	    		int x = ps.executeUpdate();
    	    		if (x == 1){
    	    			session.setAttribute("user", username);
    	    			response.sendRedirect("editPerson.jsp");
    	    		}
     			}
     			else if (session.getAttribute("type").equals("login")){
     				ResultSet rs = stmt.executeQuery("select * from users where username='" + username + "' and password='" + password + "'");
     			    if (rs.next()) {
     			        session.setAttribute("user", username); // the username will be stored in the session
     			        if(username.equals("admin")){
     			        	session.setAttribute("role", "admin");
     			        	response.sendRedirect("Home.jsp");
     			        }
     			        response.sendRedirect("Home.jsp");
     			    } else {
     			        out.println("<h1> Oops! Invalid username or password. </h1> <br> <a href='index.jsp'>Click here to try again</a>");
     			    }
     			}
     			
     			db.closeConnection(con);
	     	} catch (SQLException e) {
				if (e.getSQLState().startsWith("23")){
					session.invalidate();
					out.println("<h1 style='color:red'> Sorry. This username is already been taken! Try another one. </h1> <a href='index.jsp'>Click here to try again</a>");
				}
			}
			catch (Exception e) {
				out.print(e);
			}
     %>
</body>
</html>