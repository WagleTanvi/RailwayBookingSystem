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
<title>Train Schedule</title>
</head>
<style>
.overlay {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.7);
  transition: opacity 500ms;
  visibility: hidden;
  opacity: 0; 
}
.overlay:target {
  visibility: visible;
  opacity: 1;
}
.popup {
  margin: 70px auto;
  padding: 20px;
  background: #fff;
  border-radius: 5px;
  width: 30%;
  position: relative;
  transition: all 5s ease-in-out;
  text-align: center;
}

.popup h2 {
  margin-top: 0;
  color: #333;
  font-family: Tahoma, Arial, sans-serif;
}
.popup .content {
  max-height: 30%;
  overflow: auto;
}

@media screen and (max-width: 700px){
  .popup{
    width: 70%;
  }
}
a {
	text-decoration: none;
}
</style>
<body>
	<%
	 	String personType = (String)session.getAttribute("role");
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		/* Get stations for the Origin and Destination Dropdown */
		ResultSet rs = stmt.executeQuery("SELECT * from station;");
		ArrayList<String> stations = new ArrayList<String> ();
		while (rs.next()){
			stations.add(rs.getString("name"));
		}
		rs = stmt.executeQuery("Select username from users where role='customer';");
		ArrayList<String> users = new ArrayList<String> ();
		while (rs.next()){
			users.add(rs.getString("username"));
		}
		/* if (session.getAttribute("data") != null){
			for (TrainScheduleObject t: (ArrayList<TrainScheduleObject>)session.getAttribute("data")){
				out.println(t);
			}
		} */
		
/*
		rs = stmt.executeQuery("SELECT distinct date from train_schedule;");
		ArrayList<String> dates = new ArrayList<String> ();
		while (rs.next()){
			dates.add(rs.getDate("date").toString());
		} */
		System.out.println(session.getAttribute("data"));

	%>
	<button style="background-color: green; position:absolute; top:20px; left: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="HandleTrainSchedule.jsp?clear=true">Home</a></button>
	<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
	<h1 style="text-align:center"> Train Schedule </h1>
	<div style="display: flex; justify-content:center;" >
	<form method="get" action="HandleTrainSchedule.jsp">
	<table>
	<tr>
		<td>
			<%if (session.getAttribute("date") == null){ %>
				<input type="date" id="date" name="date" > <!--  ONLY SUPPORTED IN Internet Explorer --> 	
			<%
	        		} else{
	        %>
	        			<input type="date" id="date" name="date" value=<%= session.getAttribute("date") %>>
	        			
	         <% } %>
		</td>
		<td>
			<select name="origin" id ="origin"> 
			<%if (session.getAttribute("origin") == null){ %>
				<option  disabled selected>Select Your Origin Station</option>
			<% } %>
	        <%  for (String s : stations){ 
	        		String s_temp = s.replace(" ", "+");
	        		if (session.getAttribute("origin") != null && session.getAttribute("origin").equals(s)){
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
			<select name="destination" id ="destination"> 
			<%if (session.getAttribute("destination") == null){ %>
				<option  disabled selected>Select Your Destination Station</option>
			<% } %>
	        <%  for (String s : stations){ 
	        		String s_temp = s.replace(" ", "+");
	        		if (session.getAttribute("destination") != null && session.getAttribute("destination").equals(s)){
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
			<input type="submit" value="Filter" />
		</td>
		
	</tr>	
	</table>
	</form>
	</div>
	<div style="display: flex; justify-content:center;" >
	<table>
		<td><a href="resPage.jsp"><button> <% if (personType.equals("customer")){ out.println("See My Reservations");} else { out.println("See Customer Reservations");} %></button></a></td>
		<% if (!personType.equals("customer")){ %> 
		<td> <button> <a href="HandleTrainSchedule.jsp?clear=manage">Manage Train Schedule </a></button></td>
		<%} %>
	</table>
	</div>
	<div style="display: flex; justify-content:center;" >
	<% if (session.getAttribute("t_error") != null){ 
		out.println(session.getAttribute("t_error"));
		session.removeAttribute("t_error");
	  } else { %>
	<table style="border: 1px solid black; border-collapse: collapse;" >
		<% if (session.getAttribute("data") != null){ %>
		<tr> 
			<th style="border: 1px solid black;"> Transit Line </th>
			<th style="border: 1px solid black;"> Departure Time </th>
			<th style="border: 1px solid black;"> Arrival Time </th>
			<th style="border: 1px solid black;"> Start Station </th>
			<th style="border: 1px solid black;"> End Station </th>
			<th style="border: 1px solid black;"> Travel Time </th>
			<th style="border: 1px solid black;"> Cost </th> 
			 <th style="border: 1px solid black;">		</th> 
		</tr>
			<% for (TrainScheduleObject t: (ArrayList<TrainScheduleObject>)session.getAttribute("data")){
				%>
				<tr>
				<%= t.getData(personType) %>
				</tr>
				<% 
			}
		} %>
	</table>
	<%} %>
	</div>
	<% if (request.getParameter("fare") != null){ %>
	<div id="popup1" class="overlay">
		<div class="popup">
			<% 
				session.setAttribute("r_fare", request.getParameter("fare"));
				session.setAttribute("schedule", request.getParameter("schedule"));
			%> 
			<h3>Select More Ticket Information</h3>
			<b>Date:</b> <%= session.getAttribute("date") %>
			<b>Train Number:</b> <%= request.getParameter("schedule") %><br>
			<b>Origin:</b> <%= session.getAttribute("origin") %><br>
			<b> Destination: </b> <%= session.getAttribute("destination") %> <br>
			<div class="content">
				<form action="HandleTrainSchedule.jsp">
				 <%if (!personType.equals("customer")){ %>
				 <b>Please select user:</b>
				  <select name="username" id ="username"> 
				        <%  for (String s : users){ %>
				            <option value=<%= s%>><%= s %></option>
				         <%} %>
			       </select> 
			       <% } %>
				  <p><b>Please select ticket type:</b></p>
				  <input type="radio" id="one" name="trip" value="one" checked>
				  <label for="one">One-Way</label>
				  <input type="radio" id="two" name="trip" value="two">
				  <label for="two">Round-Trip</label><br>
				  <input type="radio" id="weekly" name="trip" value="weekly">
				  <label for="weekly">Weekly</label> 
				  <input type="radio" id="monthly" name="trip" value="monthly">
				  <label for="monthly">Monthly</label><br>
				  
				  <p><b>Please select discount type:</b></p>
				  <input type="radio" id="normal" name="discount" value="normal" checked>
				  <label for="discount">Normal</label>
				  <input type="radio" id="senior/child" name="discount" value="senior/child">
				  <label for="senior">Senior</label> 
				  <input type="radio" id="disabled" name="discount" value="disabled">
				  <label for="child/disabled">Child/Disabled</label><br>
				  
				   <p><b>Please select class:</b></p>
				  <input type="radio" id="Business" name="class" value="Business" checked>
				  <label for="business">Business</label>
				  <input type="radio" id="First" name="class" value="First">
				  <label for="First">First</label>
				  <input type="radio" id="Economy" name="class" value="Economy">
				  <label for="Economy">Economy</label><br><br>
			       <input type="submit" value="Submit">
				  <button><a href="#">Close</a></button>
				</form>
			</div>
		</div>
	</div>
	<% } %>
</body>
</html>