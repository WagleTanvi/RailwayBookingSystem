<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Sales Reports</title>
	</head>
	
	<body>
		<h1>Sales Reports</h1>
		
		<form>
			<select id="Listing" onchange = "">
			  <option value = "">- Listing -</option>
			  <option value = "TL">Transit Line</option>
			  <option value = "DC">Destination City</option>
			  <option value = "CUS">Customer</option>
			  <option value = "BC">Best Customer</option>
			  <option value = "BL">Best Line </option>
			</select>
			
		&nbsp;
		&nbsp;
	
			<select id="Month" onchange = "">
			  <option value = "">- Month -</option> 
			  <option value = "Jan">Jan</option>
			  <option value = "Feb">Feb</option>
			  <option value = "Mar">Mar</option>
			  <option value = "Apr">Apr</option>
			  <option value= "May">May</option>
			  <option value = "Jun">Jun</option>
			  <option value = "Jul">Jul</option>
			  <option value = "Aug">Aug</option>
			  <option value = "Sep">Sep</option>
			  <option value = "Oct">Oct</option>
			  <option value = "Nov">Nov</option>
			  <option value = "Dec">Dec</option>
			</select>
		</form>
	
		<button type="Logout" onclick="window.location.href = 'logout.jsp';">Logout</button>
		    
	    <table style="width:100%">
  		<tr>
	    	<th>Sales</th>
	    	<th>Test</th>
	    	<th>Test</th>
		</tr>
		</table>

	</body>
	
	<script>
	
     	var l = document.getElementById("Listing");
		var listing = l.options[l.selectedIndex].value;
		
		var m = document.getElementById("Month");
		var month = m.options[m.selectedIndex].value;
	

    </script>
</html>
