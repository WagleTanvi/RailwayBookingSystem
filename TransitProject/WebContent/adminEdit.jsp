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

<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
	<% 
	
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String user = request.getParameter("value");
		String statement = "SELECT username, ssn, fname, lname, telephone, city, state, role, zipcode, email, role FROM users WHERE username = ?";
		PreparedStatement ps = con.prepareStatement(statement);
    	ps.setString(1, user);
    	rs = ps.executeQuery();
    	rs.next();
    	String fname = rs.getString("fname");
    	session.setAttribute("a_fname", fname);
		String zipcode = rs.getString("zipcode");
		session.setAttribute("a_zipcode", zipcode);
		String email = rs.getString("email");
		session.setAttribute("a_email", email);
		String lname = rs.getString("lname");
		session.setAttribute("a_lname", lname);
		String telephone = rs.getString("telephone");
		session.setAttribute("a_telephone", telephone);
		String city = rs.getString("city");
		session.setAttribute("a_city", city);
		String state = rs.getString("state");
		session.setAttribute("a_state", state);
		String ssn = rs.getString("ssn");
		session.setAttribute("a_ssn", ssn);
		
 	   db.closeConnection(con);
  	}
 	    	catch (SQLException e) {
 				if (e.getSQLState().startsWith("23")){
 					session.invalidate();
 					out.println("<h1 style='color:red'> Sorry, there was an error! Please try again! </h1> <a href='index.jsp'>Click here to try again</a>");
 				}
 			}
 			catch (Exception e) {
 				out.print(e);
 			}
		%>

	<form action="HandleAdminEdit.jsp?value=<%=request.getParameter("value") %>" method="POST">
    	First Name: <input type="text" id = "fname" name="fname" value = "<%= session.getAttribute("a_fname") %>"/> <br/>
    	Last Name: <input type="text" name="lname" value = "<%= session.getAttribute("a_lname") %>"/> <br/>
    	SSN: <input type="text" id = "ssn" name="ssn" value = "<%= session.getAttribute("a_ssn") %>"/> <br/>
    	Zipcode:<input type="text" name="zipcode" value = "<%= session.getAttribute("a_zipcode") %>"/> <br/>
    	Email:<input type="text" name="email" value = "<%= session.getAttribute("a_email") %>"/> <br/>
    	Telephone:<input type="text" name="telephone" value = "<%= session.getAttribute("a_telephone") %>"/> <br/>
    	City:<input type="text" name="city" value = "<%= session.getAttribute("a_city") %>"/> <br/>
    	State:<input type="text" name="state" value = "<%= session.getAttribute("a_state") %>"/> <br/>
    <label for="Role">Role:</label>
	   <select name="role">
		 <option value="customer" >Customer</option>
		 <option value = "customer_service_rep">Customer Representative</option>
	   </select>
  	<input type="submit" value="Submit"/>
  </form>
</body>
</html>
