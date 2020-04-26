<!-- Written By: Tanvi Wagle tnw39 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Browse Train Schedule</title>
</head>
<body>
<%
	 	String personType = (String)session.getAttribute("role");
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		/* Get stations for the Origin and Destination Dropdown */
		ResultSet rs = stmt.executeQuery("SELECT tl_name from transit_line;");
		ArrayList<String> lines = new ArrayList<String> ();
		while (rs.next()){
			lines.add(rs.getString("tl_name"));
		}
		

	%>
	<button style="background-color: green; position:absolute; top:20px; left: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="HandleBrowse.jsp?clear=true">Home</a></button>
	<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
	<h1 style="text-align:center"> View All Train Schedules </h1>
	<div style="display: flex; justify-content:center;" >
	<form method="get" action="HandleBrowse.jsp">
	<table>
	<tr>
		<td>
			<select name="b_line" id ="b_line"> 
			<%if (session.getAttribute("b_line") == null){ %>
				<option  disabled selected>Select Your Destination Station</option>
			<% } %>
	        <%  for (String s : lines){ 
	        		String s_temp = s.replace(" ", "+");
	        		if (session.getAttribute("b_line") != null && session.getAttribute("b_line").equals(s)){
	        %>
	            <option value=<%= s_temp %>  selected><%= s %></option>
	        <%
	        		} else{
	        %>
	        	<option value=<%= s_temp %>><%= s %></option>
	        <% }} %>
       </select> 
		</td>
		<td>
			<select name="sort" id ="sort"> 
	        <%if (session.getAttribute("b_sort") == null){ %>
				<option  disabled selected>Sort By</option>
				<option value="fare">Fare</option>
		        <option value="tsm2.arrival_time">Arrival Time</option>
		        <option value="tsm1.departure_time">Destination Time</option>
		        <option value="start"> Origin Station </option>
		        <option value="end">Destination Station</option>
			<% } else {%>
	        <%if (session.getAttribute("b_sort").equals("fare")){ %> <option value="fare" selected>Fare</option> <% } else {%> <option value="fare">Fare</option> <%} %>
	        <%if (session.getAttribute("b_sort").equals("tsm2.arrival_time")){ %> <option value="tsm2.arrival_time" selected>Arrival Time</option> <% } else {%> <option value="tsm2.arrival_time">Arrival Time</option>  <%} %>
	        <%if (session.getAttribute("b_sort").equals("tsm1.departure_time")){ %> <option value="tsm1.departure_time" selected >Destination Time</option> <% } else {%>  <option value="tsm1.departure_time">Destination Time</option>  <%} %>
	        <%if (session.getAttribute("b_sort").equals("start")){ %> <option value="start" selected> Origin Station </option> <% } else {%> <option value="start"> Origin Station </option> <%} %>
	        <%if (session.getAttribute("b_sort").equals("end")){ %><option value="end" selected>Destination Station</option> <% } else {%> <option value="end">Destination Station</option>  <%} %>
       		<% } %>
	        
	        
	        
	        
	        
        </select> 
		</td>
		<td>
			<input type="submit" value="Filter" />
		</td>
		
	</tr>	
	</table>
	</form>
	</div>
	<div style="display: flex; justify-content:center;" >
	<table style="border: 1px solid black; border-collapse: collapse;" >
		<% if (session.getAttribute("b_data") != null){ %>
		<tr> 
			<th style="border: 1px solid black;"> Transit Line </th>
			<th style="border: 1px solid black;"> Schedule Number </th>
			<th style="border: 1px solid black;"> Start Station </th>
			<th style="border: 1px solid black;"> End Station </th>
			<th style="border: 1px solid black;"> Departure Time </th>
			<th style="border: 1px solid black;"> Arrival Time </th>
			<th style="border: 1px solid black;"> Cost </th> 
		</tr>
			<% for (TrainScheduleObject t: (ArrayList<TrainScheduleObject>)session.getAttribute("b_data")){
				%>
				<tr>
				<%= t.getBrowseData() %>
				</tr>
				<% 
			}
		} %>
	</table>
</body>
</html>