<!-- Written By: Zaid Meer zsm7 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1> Edit Person: </h1>
 
     <form action="HandlePerson.jsp" method="POST">
       First Name: <input type="text" name="fname"/> <br/>
       Last Name: <input type="text" name="lname"/> <br/>
       SSN: <input type="text" name="ssn"/> <br/>
       Zipcode:<input type="text" name="zipcode"/> <br/>
       Email:<input type="text" name="email"/> <br/>
       Telephone:<input type="text" name="telephone"/> <br/>
       City:<input type="text" name="city"/> <br/>
       State:<input type="text" name="state"/> <br/>
       <label for="Role">Role:</label>
	   <select name="role">
		 <option value="customer" >Customer</option>
		 <option value = "customer_service_rep">Customer Representative</option>
	   </select>
     	<input type="submit" value="Submit"/>
     </form>
	
</body>
</html>
