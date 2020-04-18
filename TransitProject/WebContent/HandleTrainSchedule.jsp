<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// case when the stations are equal to eachother 
	
	// 1. check if the stations are on the same transit line
	// 2. check direction
	// 3. check route_id
	// 4. query for route_id in schedule timings
	
	
	String date = request.getParameter("date");
	String origin = request.getParameter("origin").replace("+", " ");
	String destination = request.getParameter("destination").replace("+", " ");
	/* String sort = request.getParameter("sort"); */
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	String statement = "SELECT min(r.hop_number) min from transit_line_route r, station s where r.start_station_id = s.station_id and s.name = ?";
	PreparedStatement ps = con.prepareStatement(statement);
	ps.setString(1,origin);
    ResultSet rs = ps.executeQuery();
    int start = -1;
	if (rs.next()){
		start = rs.getInt("min");
	}
	statement = "SELECT min(r.hop_number) min from transit_line_route r, station s where r.end_station_id = s.station_id and s.name = ?";
	ps = con.prepareStatement(statement);
	ps.setString(1,origin);
    rs = ps.executeQuery();
    int end = -1;
	if (rs.next()){
		end = rs.getInt("min");
	}
	String direction = "";
	if (start < end){

		direction = "up";
	}
	else {
		direction = "down";
	}
	session.setAttribute("direction", direction);
	//out.println(direction);
	
	statement = "SELECT min(r.hop_number) min from transit_line_route r, station s where r.end_station_id = s.station_id and s.name = ?";
	ps = con.prepareStatement(statement);
	ps.setString(1,origin);
    rs = ps.executeQuery();
    
    statement = "SELECT tl.tl_name, r.route_id, ts.schedule_num, ? start, ? end, min(ts.departure_time) departure, max(ts.arrival_time) arrival, SUBTIME(max(ts.arrival_time), min(ts.departure_time)) travel_time,  (tl.fare)*(max(r.hop_number) - min(r.hop_number)+1) cost "
    		+ " from transit_line_route r, station s1, station s2, train_schedule_timings ts, transit_line tl"
    		+" where r.start_station_id = s1.station_id and r.end_station_id = s2.station_id and"
    		 +" ts.route_id = r.route_id and (s1.name =  ? or s2.name = ?) and direction = ?"
    		 +" group by ts.schedule_num;";
    		 
    ps = con.prepareStatement(statement);		 
    ps.setString(1,origin);
    ps.setString(2,destination);
    ps.setString(3,origin);
    ps.setString(4,destination);
    ps.setString(5,direction);
    rs = ps.executeQuery();

	ArrayList<TrainScheduleObject> list = new ArrayList<TrainScheduleObject>();
	while (rs.next()){
		list.add(new TrainScheduleObject(
				rs.getString("tl_name"),
				rs.getInt("schedule_num"),
				rs.getInt("route_id"),
				rs.getString("departure"),
				rs.getString("arrival"),
				rs.getString("start"),
				rs.getString("end"),
				rs.getString("travel_time"),
				rs.getInt("cost")
				)); 
		/* out.print(""+rs.getString("tl_id"));
		out.print("\t"+rs.getString("departure"));
		out.print("\t "+rs.getString("arrival"));
		out.print("\t "+rs.getString("start"));
		out.print("\t"+rs.getString("end"));
		//out.print("\t"+rs.getString("travel time"));
		out.println(rs.getInt("cost"));  */
	} 
	session.setAttribute("origin", origin);
	session.setAttribute("destination", destination);
	session.setAttribute("date", date);
	session.setAttribute("data", list);
	response.sendRedirect("TrainSchedule.jsp");  
	
	%>
</body>
</html>