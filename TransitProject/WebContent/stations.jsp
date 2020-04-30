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
	String scheduleNum = (String) request.getParameter("num");
	String statement = "Select s1.name start, s2.name end, s1.state_name, s1.city_name, s2.state_name twoS, s2.city_name twoC, tsm.departure_time, tsm.arrival_time"
			+" from transit_line_route tr, train_schedule_timings tsm, station s1, station s2" 
			+" where tsm.schedule_num=? and tsm.route_id = tr.route_id and tr.start_station_id = s1.station_id and tr.end_station_id = s2.station_id;";

	PreparedStatement ps = con.prepareStatement(statement);
	ps.setInt(1,Integer.parseInt(scheduleNum));
    ResultSet rs = ps.executeQuery();
    ArrayList<Stations> stationsList = new ArrayList<Stations> ();
	while (rs.next()){
		stationsList.add(new Stations(
				rs.getString("start"),
				rs.getString("state_name"),
				rs.getString("city_name"),
				rs.getString("departure_time"),
				rs.getString("arrival_time"),
				rs.getString("end"),
				rs.getString("twoS"),
				rs.getString("twoC")
				));
	}
	stationsList.add(new Stations(
			stationsList.get(stationsList.size()-1).getEnd(), 
			stationsList.get(stationsList.size()-1).getEState(),
			stationsList.get(stationsList.size()-1).getECity(),
			stationsList.get(stationsList.size()-1).getArrival(),
			"",
			"",
			"",
			""
			));
	db.closeConnection(con);
	%>
	<button style="background-color: green; position:absolute; top:20px; left: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="Home.jsp">Home</a></button>
	<button style="background-color: red; position:absolute; top:20px; right: 30px; border-radius: 10px;"><a style="color: black; text-decoration: none; font-size: 20px;"href="logout.jsp">Logout</a></button>
	<h3 style="text-align:center"> Station Schedule for <%=transitLine%> #<%=scheduleNum%></h3>
	<div style="display: flex; justify-content:center;" >
	<table style="border: 1px solid black; border-collapse: collapse;" >
		<tr>
		<th style="border: 1px solid black;">Name</th>
		<th style="border: 1px solid black;">State</th>
		<th style="border: 1px solid black;">City</th>
		<th style="border: 1px solid black;">Time</th>
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