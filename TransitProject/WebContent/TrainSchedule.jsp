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
	 	String personType = "customer rep";
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		/* Get stations for the Origin and Destination Dropdown */
		ResultSet rs = stmt.executeQuery("SELECT * from station;");
		ArrayList<String> stations = new ArrayList<String> ();
		while (rs.next()){
			stations.add(rs.getString("name"));
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
		

	%>
	<button style="background-color: green; position:absolute; top:20px; left: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="">Home</a></button>
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
		<!-- <td>
			<select name="sort" id ="sort"> 
			<option  disabled selected>Sort By</option>
	        <option value="date">Date</option>
	        <option value="fare">Fare</option>
	        <option value="arrival time">Arrival Time</option>
	        <option value="destination time">Destination Time</option>
	        <option value="origin station"> Origin Station </option>
	        <option value="destination station">Destination Station</option>
        </select> 
		</td> -->
		<td>
			<input type="submit" value="Filter" />
		</td>
		
	</tr>	
	</table>
	</form>
	</div>
	<div style="display: flex; justify-content:center;" >
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
			 <% if (personType.equals("customer")){ %> <th style="border: 1px solid black;">		</th>  <%} %>
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
	<table style="position:absolute; bottom:100px;">
		<td><button> <% if (personType.equals("customer")){ out.println("See My Reservations");} else { out.println("See Customer Reservations");} %></button></td>
		<% if (!personType.equals("customer")){ %> 
		<td> <button> <a href="manageTrainSchedule.jsp">Manage Train Schedule </a></button></td>
		<%} %>
	</table>
	
	</div>
	<div id="popup1" class="overlay">
		<div class="popup">
			<h2>Select More Ticket Information</h2>
			<p><b>Train Number:</b> <%= request.getParameter("schedule") %></p>
			<p><b>Origin:</b> <%= request.getParameter("origin") %></p>
			<p><b> Destination: </b> <%= request.getParameter("dest") %></p>
			<div class="content">
				<form action="success.jsp?schedule=">
				  <p>Please select ticket type:</p>
				  <input type="radio" id="one" name="trip" value="one">
				  <label for="one">One-Way</label>
				  <input type="radio" id="two" name="trip" value="two">
				  <label for="two">Round-Trip</label><br>
				  <input type="radio" id="weekly" name="trip" value="weekly">
				  <label for="weekly">Weekly</label> 
				  <input type="radio" id="monthly" name="trip" value="monthly">
				  <label for="monthly">Monthly</label><br>
				  
				  <p>Please select discount type:</p>
				  <input type="radio" id="normal" name="discount" value="normal">
				  <label for="discount">Normal</label><br>
				  <input type="radio" id="senior" name="discount" value="senior">
				  <label for="senior">Senior</label><br>  
				  <input type="radio" id="child/disabled" name="discount" value="child/disabled">
				  <label for="child/disabled">Child/Disabled</label><br><br>
				  <input type="submit" value="Submit">
				  <button><a href="#">Close</a></button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>