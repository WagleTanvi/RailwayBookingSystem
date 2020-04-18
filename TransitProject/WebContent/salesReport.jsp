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
		
		<select id="Listing">
		  <option value = "">- Listing -</option>
		  <option value = "TL">Transit Line</option>
		  <option value = "DC">Destination City</option>
		  <option value = "CUS">Customer</option>
		  <option value = "BC">Best Customer</option>
		  <option value = "BL">Best Line </option>
		</select>
		<label class = "TL" for="TL">TL</label>
		<label class = "DC" for="DC">DC</label>
		<label class = "CUS" for="CUS">CUS</label>
		<label class = "BC" for="BC">BC</label>
		<label class = "BL" for="BL">BL</label>
		&nbsp;
		&nbsp;
		<select id="Month">
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
		<label class="Jan" for="Jan">January Name</label>
        <label class="Feb" for="Feb">February Name</label>
        <label class="March" for="March">March Name</label>
        <label class="Apr" for="Apr">April Name</label>        
        <label class="May" for="May">May Name</label>
        <label class="Jun" for="Jun">June Name</label>        
        <label class="Jul" for="Jul">July Name</label>
        <label class="Aug" for="Aug">August Name</label>
        <label class="Sep" for="Sep">September Name</label>
        <label class="Oct" for="Oct">October Name</label>
        <label class="Nov" for="Nov">November Name</label>
        <label class="Dec" for="Dec">December Name</label>
	
		<button type="Logout" onclick="window.location.href = 'logout.jsp';">Logout</button>
		    
	    <table style="width:100%">
  		<tr>
	    	<th>Sales</th>
	    	<th>Test</th>
	    	<th>Test</th>
		</tr>
		
		  
	</body>
	<script src="salesReport.js"></script>
</html>
