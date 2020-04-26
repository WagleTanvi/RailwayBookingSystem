<!-- Written By: Tanvi Wagle tnw39 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %><!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stations</title>
</head>
<body>
	<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	String origin = (String) session.getAttribute("origin");
	String dest = (String) session.getAttribute("destination");
	String transitLine = (String) request.getParameter("transit");
	String statement = "SELECT distinct s.name, s.state_name, s.city_name"
			+" from transit_line tl, transit_line_route r, station s"
			+" where tl.tl_id = r.tl_id and tl.tl_name = ? and r.start_station_id = s.station_id";
	PreparedStatement ps = con.prepareStatement(statement);
	ps.setString(1,transitLine);
    ResultSet rs = ps.executeQuery();
    ArrayList<Stations> stationsList = new ArrayList<Stations> ();
	while (rs.next()){
		stationsList.add(new Stations(rs.getString("name"),rs.getString("state_name"),rs.getString("city_name")));
	}
	%>
	<button style="background-color: green; position:absolute; top:20px; left: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="">Home</a></button>
	<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
	<h3 style="text-align:center"> Stations for <%=transitLine%></h3>
	<div style="display: flex; justify-content:center;" >
	<table style="border: 1px solid black; border-collapse: collapse;" >
		<tr>
		<th style="border: 1px solid black;">Name</th>
		<th style="border: 1px solid black;">State</th>
		<th style="border: 1px solid black;">City</th>
		</tr>
		<% for (Stations t: stationsList){
				%>
				<tr>
				<% if (t.getName().equals(origin) || t.getName().equals(dest)) {%>
				<%= t.getRow(true) %>
				<%} else{ %>
				<%= t.getRow(false) %>
				<%} %>
				</tr>
				<% 
			}
		%>
	</table>
	</div>
	<br>
	<br>
	<div style="display: flex; justify-content:center;" >
	<button><a href="TrainSchedule.jsp">Back to Schedules</a></button>
	</div>

</body>
</html>