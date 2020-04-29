<!-- WRITTEN BY ZAID MEER zsm7 CSS WRITTEN BY BONING DING bnd28 -->

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

<style>
	/* CODE STARTING HERE BY bnd28 */
	body {
			font-family: Arial, Helvetica, sans-serif;
	}
	table, td, th {
  			border: 1px solid black;
	}
		
	table {
		  border-collapse: collapse;
		  margin-bottom: 2%;
		  margin-top: 2%;
		  width: 80%;
   		  margin-left: 10%;
	}
		
	th {
		  text-align: left;
	}
		
	h3, h1 {
			text-align: center;
	}
	
	.register {
		margin-left: 20%;
	}
	
	.userSelect {
		float: right;
    	margin-right: 15%;
    	width: 30%;
	}
	
	.userSelect form p {
		float: left;
    	margin-top: 0%;
    	margin-right: 1%;
	}
	/* CODE ENDING HERE BY bnd28 */
</style>
</head>
<body>
<button style="background-color: green; position:absolute; top:20px; left: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="Home.jsp">Home</a></button>
<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
<h1 style="text-align:center"> Users </h1>
<a class="register" href ='formPage.jsp?command=register' class = "btn btn-warning">Register a User</a>
<div class="userSelect">
<form action = "People.jsp" method = "POST">

<p><strong>Select User Role: </strong></p>
<select name="role">
		<option value="all" >All</option>
		 <option value="customer" >Customer</option>
		 <option value = "customer representative">Customer Representative</option>
</select>


<input type="submit" value="Submit"/>
</form>
</div>

<table>
	<tr>
		<th> Username </th>
		<th> Email </th>
		<th> SSN </th>
		<th> First Name </th>
		<th> Last Name </th>
		<th> Telephone </th>
		<th> City </th>
		<th> State </th>
		<th> Zipcode </th>
		<th> Role </th>
		<th> Edit </th>
		<th> Delete </th>
	</tr>
	<% 
	
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String s = null;
		if(session.getAttribute("filterRole").equals("all")){
			s = "all";
		}
		else{
			s = request.getParameter("role");
		}
		
		if(s == null) {
			s = "all";
		}
		
		if(s.equals("customer")){
				session.setAttribute("filterRole", "customer");
				rs = stmt.executeQuery("SELECT username, ssn, fname, lname, telephone, city, state, role, zipcode, email, role FROM users WHERE role = 'customer'");
			}
		else if(s.equals("customer representative")){
				session.setAttribute("filterRole", "customer rep");
				rs = stmt.executeQuery("SELECT username, ssn, fname, lname, telephone, city, state, role, zipcode, email, role FROM users WHERE role = 'customer_service_rep'");
			}
		else if(s.equals("all")){
				session.setAttribute("filterRole", "null");
				rs = stmt.executeQuery("SELECT username, ssn, fname, lname, telephone, city, state, role, zipcode, email, role FROM users");
		}
		
		while(rs.next()){
		%>
			<tr>
			<td><%=rs.getString("username") %> </td>
			<td><%=rs.getString("email") %> </td>
			<td><%=rs.getString("ssn") %> </td>
			<td><%=rs.getString("fname") %> </td>
			<td><%=rs.getString("lname") %> </td>
			<td><%=rs.getString("telephone") %> </td>
			<td><%=rs.getString("city") %> </td>
			<td><%=rs.getString("state") %> </td>
			<td><%=rs.getString("zipcode") %> </td>
			<td><%=rs.getString("role") %> </td>
			<td>
				<a href ="adminEdit.jsp?value=<%=rs.getString("username") %>" class = "btn btn-warning"> Edit </a> 
			</td>
			<td>
				<a href ="deletePerson.jsp?value=<%=rs.getString("username") %>" class = "btn btn-warning"> Delete </a> 
			</td>
			</tr>
		
		<%
		}

		db.closeConnection(con);
	}
	
	catch (Exception e) {
		out.print(e);
	}

	 %>
</table>
</body>
</html>