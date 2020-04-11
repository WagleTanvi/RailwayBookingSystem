<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Sales Reports</title>
	</head>
	
	<body>
		<h1>Sales Reports</h1>	
		
		<label for="Listing">Listing:</label>
		<select id="Listing">
		  <option >Transit Line</option>
		  <option >Destination City</option>
		  <option >Customer Name</option>
		  <option >Best Customer</option>
		  <option >Best Line </option>
		</select>
		&nbsp;
		&nbsp;
		<label for="Month">Month:</label>
		<select id="Month">
		  <option value="Jan">Jan</option>
		  <option >Feb</option>
		  <option >Mar</option>
		  <option >Apr</option>
		  <option >May</option>
		  <option >Jun</option>
		  <option >Jul</option>
		  <option >Aug</option>
		  <option >Sep</option>
		  <option >Oct</option>
		  <option >Nov</option>
		  <option >Dec</option>
		</select>
	
		<button type="Logout" onclick="window.location.href = 'logout.jsp';">Logout</button>
		  
	</body>
</html>
